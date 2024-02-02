// ignore_for_file: prefer_is_empty

import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';

enum PinPageType {
  onboarding,
  unlock,
  createPin,
  editPin,
}

enum PinPageStatus {
  preCheck,
  nomal,
  doubleCheck,
}

class PinPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final String? redirect = Get.arguments?['redirect'];

  final PinPageType pinPageType = Get.arguments?['pinPageType'] ?? PinPageType.unlock;

  final Rx<PinPageStatus> _status = Rx(PinPageStatus.nomal);
  PinPageStatus get status => _status.value;

  final Rx<List<int>> _nums = Rx([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  List<int> get nums => _nums.value;

  final Rx<String> _pin = Rx('');
  String get pin => _pin.value;

  final Rx<int?> _pinCount = Rx(null);
  int? get pinCount => _pinCount.value;

  bool get pinLocked => _pinCount.value != null && _pinCount.value! <= 0;

  bool get backBtnEnabled => pin.isNotEmpty && pin.length < 4;
  bool get numpadEnabled => pin.length < 4;

  @override
  void onInit() {
    _shufleList();
    super.onInit();
  }

  void _shufleList() {
    _nums.value.shuffle();
    _nums.refresh();
  }

  Future onboardingAuth() async {
    try {
      await authService.onBoardingAuth(pin);
      final String nextRoute = redirect ?? Routes.HOME;
      Get.offAllNamed(nextRoute);
    } on IncorrectPinException catch (e) {
      _pinCount.value = e.left;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
      clearPin();
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

  void validatePin() async {
    try {
      await authService.validatePin(pin);
      Get.back();
    } on IncorrectPinException catch (e) {
      _pinCount.value = e.left;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
    } on PinLockException catch (_) {
      _pinCount.value = 0;
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.vibrate);
    }
  }

  void clearPin() {
    _pin.value = '';
  }
}
