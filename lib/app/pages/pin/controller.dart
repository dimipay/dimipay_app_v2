// ignore_for_file: prefer_is_empty

import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/pages/pin/page.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/bio_auth/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

enum PinPageType {
  unlock,
  onboarding,
  createPin,
  editPin,
  register,
}

enum PinPageStatus {
  preCheck,
  normal,
  wrong,
  doubleCheck,
}

class PinPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final String? redirect = Get.arguments?['redirect'];

  final PinPageType pinPageType = Get.arguments?['pinPageType'] ?? PinPageType.unlock;

  final Rx<PinPageStatus> _status = Rx(PinPageStatus.normal);
  PinPageStatus get status => _status.value;

  final Rx<List<int>> _nums = Rx([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  List<int> get nums => _nums.value;

  final Rx<String> _pin = Rx('');
  String get pin => _pin.value;

  late String _newPin;

  final Rx<int?> _pinCount = Rx(null);
  int? get pinCount => _pinCount.value;

  bool get pinLocked => _pinCount.value != null && _pinCount.value! <= 0;

  bool get backBtnEnabled => pin.isNotEmpty && pin.length < 4;
  bool get numpadEnabled => pin.length < 4;

  @override
  void onInit() {
    _shufleList();
    _initStatus();
    super.onInit();
  }

  void _shufleList() {
    _nums.value.shuffle();
    _nums.refresh();
  }

  Future<bool> authWithFaceID() async {
    final LocalAuthService localAuthService = Get.find<LocalAuthService>();
    try {
      final res = await localAuthService.bioAuth();

      if (res) {
        await authService.bioKey.loadBioKey();
        Get.back();
        return true;
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        return false;
      } else {
        DPErrorSnackBar().open('생체 인증을 사용할 수 없습니다.(code: ${e.code})');
      }
    }
    return false;
  }

  void _initStatus() {
    switch (pinPageType) {
      case PinPageType.unlock:
        _status.value = PinPageStatus.normal;
      case PinPageType.onboarding:
        _status.value = PinPageStatus.normal;
      case PinPageType.editPin:
        _status.value = PinPageStatus.preCheck;
      case PinPageType.createPin:
        _status.value = PinPageStatus.normal;
      case PinPageType.register:
        _status.value = PinPageStatus.normal;
    }
  }

  void onPinTap(String value) async {
    HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.light);
    if (value == 'del') {
      if (pin.length > 0 && pin.length < 4) {
        _pin.value = pin.substring(0, pin.length - 1);
      }
      return;
    }
    _pin.value += value;
  }

  Future onboardingAuth() async {
    try {
      await authService.onBoardingAuth(pin);
      final String nextRoute = redirect ?? Routes.HOME;
      Get.offAllNamed(nextRoute);
    } on IncorrectPinException catch (e) {
      _pinCount.value = e.left;
      _status.value = PinPageStatus.wrong;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
      clearPin();
    }
  }

  void pinCheck() async {
    try {
      await authService.pinCheck(pin);
      Get.back();
    } on IncorrectPinException catch (e) {
      _pinCount.value = e.left;
      _status.value = PinPageStatus.wrong;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
    } on PinLockException catch (_) {
      _pinCount.value = 0;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
    }
  }

  Future<void> changePinPreCheck() async {
    try {
      await authService.pinCheck(pin);
      _pinCount.value = null;
      _status.value = PinPageStatus.normal;
      clearPin();
      _shufleList();
    } on IncorrectPinException catch (e) {
      _pinCount.value = e.left;
      _status.value = PinPageStatus.wrong;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
    } on PinLockException catch (_) {
      _pinCount.value = 0;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
    }
  }

  Future<void> changePinNomal() async {
    try {
      validatePin(pin);
      _newPin = pin;
      _status.value = PinPageStatus.doubleCheck;
      clearPin();
      _shufleList();
    } on SameNumberPinException catch (e) {
      DPErrorSnackBar().open(e.message);
    } on ContinuousPinException catch (e) {
      DPErrorSnackBar().open(e.message);
    }
  }

  Future<void> changePinDoubleCheck() async {
    if (pin != _newPin) {
      DPErrorSnackBar().open('처음 입력한 핀과 달라요.', message: '비밀번호를 다시 입력해주세요.');
      _status.value = PinPageStatus.normal;
      return;
    }
    await authService.changePin(pin);
    Get.back();
    DPSnackBar.open('핀을 변경했어요!');
    HapticHelper.feedback(HapticPatterns.success);
  }

  void validatePin(String pin) {
    List<String> continuousNumber = ['0123', '1234', '2345', '3456', '4567', '5678', '6789', '7890', '9876', '8765', '7654', '6543', '5432', '4321', '3210'];
    if (continuousNumber.contains(pin)) {
      throw ContinuousPinException();
    }
    if (RegExp(r'^(.)\1{3}$').hasMatch(pin)) {
      throw SameNumberPinException();
    }
  }

  Future<void> registerPinNomal() async {
    try {
      validatePin(pin);
      _newPin = pin;
      _status.value = PinPageStatus.doubleCheck;
      clearPin();
      _shufleList();
    } on SameNumberPinException catch (e) {
      DPErrorSnackBar().open(e.message);
    } on ContinuousPinException catch (e) {
      DPErrorSnackBar().open(e.message);
    }
  }

  Future<void> registerPinDoubleCheck() async {
    if (pin != _newPin) {
      DPErrorSnackBar().open('처음 입력한 핀과 달라요.', message: '핀을 다시 입력해주세요.');
      _status.value = PinPageStatus.normal;
      return;
    }

    await authService.registerPin(pin);
    await authService.onBoardingAuth(pin);

    final String nextRoute = redirect ?? Routes.ONBOARDING;
    Get.offAllNamed(nextRoute);
  }

  void clearPin() {
    _pin.value = '';
  }
}

Future<String?> showPinDialog() async {
  BuildContext context = Get.context!;
  DPColors colorTheme = Theme.of(context).extension<DPColors>()!;
  await showModalBottomSheet(
    context: Get.context!,
    builder: (_) => SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            color: colorTheme.grayscale100,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: GetBuilder(
                  init: PinPageController(),
                  builder: (context) {
                    return const UnlockPinPage();
                  }),
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: colorTheme.grayscale100,
    elevation: 0,
  );
  AuthService authService = Get.find<AuthService>();
  return authService.pin;
}
