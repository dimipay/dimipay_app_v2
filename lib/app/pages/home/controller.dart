import 'dart:async';

import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/bio_auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import 'package:get/get.dart';

class HomePageController extends GetxController {
  final UserService userService = Get.find<UserService>();
  final PaymentService paymentService = Get.find<PaymentService>();
  final AuthService authService = Get.find<AuthService>();
  final PayService payService = Get.find<PayService>();
  final LocalAuthService localAuthService = Get.find<LocalAuthService>();

  final Rx<Duration?> timeRemaining = Rx(null);

  late Timer _displayTimer;
  Timer? _qrRefreshTimer;

  @override
  void onInit() {
    userService.fetchUser();
    paymentService.fetchPaymentMethods().then((_) => tryRequestQR());
    _displayTimer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimeRemainning());
    super.onInit();
  }

  Future<bool> biometricAuth() async {
    try {
      final res = await localAuthService.bioAuth();

      if (res) {
        await authService.loadBioKey();
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

  Future<void> tryRequestQR() async {
    if (paymentService.mainMethod == null) {
      return;
    }
    if (authService.bioKey == null) {
      await biometricAuth();
    }
    if (authService.bioKey == null && authService.pin == null) {
      await showPinDialog();
    }
    if (authService.bioKey == null && authService.pin == null) {
      return;
    }
    await payService.fetchPaymentToken(paymentService.mainMethod!);
    reserveQRRefresh(payService.expireAt!);
  }

  void reserveQRRefresh(DateTime refreshAt, {bool recursive = true}) {
    _qrRefreshTimer?.cancel();
    updateTimeRemainning(useHaptic: false);
    Duration awaitTime = refreshAt.difference(DateTime.now());
    _qrRefreshTimer = Timer(awaitTime, () async {
      timeRemaining.value = null;
      await payService.fetchPaymentToken(paymentService.mainMethod!);

      if (recursive) {
        reserveQRRefresh(payService.expireAt!);
      }
    });
  }

  void updateTimeRemainning({bool useHaptic = true}) {
    if (payService.expireAt == null || paymentService.mainMethod == null || Get.currentRoute != Routes.HOME) {
      timeRemaining.value = null;
      return;
    }
    timeRemaining.value = payService.expireAt!.difference(DateTime.now());

    if (useHaptic) {
      HapticHelper.feedback(HapticPatterns.once, hapticType: HapticType.light);
    }
  }

  @override
  void onClose() {
    _displayTimer.cancel();
    super.onClose();
  }
}
