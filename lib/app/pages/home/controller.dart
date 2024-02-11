import 'dart:async';

import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  UserService userService = Get.find<UserService>();
  PaymentService paymentService = Get.find<PaymentService>();
  AuthService authService = Get.find<AuthService>();
  PayService payService = Get.find<PayService>();
  Rx<Duration?> timeRemaining = Rx(null);

  late Timer _displayTimer;
  Timer? _qrRefreshTimer;

  @override
  void onInit() {
    userService.fetchUser();
    paymentService.fetchPaymentMethods().then((_) => tryRequestQR());
    _displayTimer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimeRemainning());
    super.onInit();
  }

  Future<void> tryRequestQR() async {
    if (paymentService.mainMethod == null) {
      return;
    }
    if (authService.pin == null) {
      final res = await showPinDialog();

      if (res == null) {
        return;
      }
    }
    await payService.fetchPaymentToken(paymentService.mainMethod!);
    reserveQRRefresh(payService.expireAt!);
  }

  void reserveQRRefresh(DateTime refreshAt, {bool recursive = true}) {
    _qrRefreshTimer?.cancel();
    Duration awaitTime = refreshAt.difference(DateTime.now());
    _qrRefreshTimer = Timer(awaitTime, () async {
      timeRemaining.value = null;
      await payService.fetchPaymentToken(paymentService.mainMethod!);
      updateTimeRemainning(useHaptic: false);

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
