import 'dart:async';
import 'dart:developer';

import 'package:dimipay_app_v2/app/core/utils/haptic.dart';
import 'package:dimipay_app_v2/app/pages/home/widgets/pay_success.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/bio_auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/model.dart';
import 'package:dimipay_app_v2/app/services/pay/service.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:screen_brightness/screen_brightness.dart';

import 'package:get/get.dart';

class HomePageController extends GetxController {
  final UserService userService = Get.find<UserService>();
  final PaymentService paymentService = Get.find<PaymentService>();
  final AuthService authService = Get.find<AuthService>();
  final PayService payService = Get.find<PayService>();
  final LocalAuthService localAuthService = Get.find<LocalAuthService>();

  final Rx<Duration?> timeRemaining = Rx(null);

  final Rx<PaymentMethod?> _selectedPaymentMethod = Rx(null);
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod.value;

  late Timer _displayTimer;
  Timer? _qrRefreshTimer;
  double? _screenBrightness;

  @override
  void onReady() {
    userService.fetchUser();
    paymentService.fetchPaymentMethods();
    paymentService.paymentStream.onData(
      (data) {
        if (_selectedPaymentMethod.value == null || paymentService.paymentMethods!.contains(_selectedPaymentMethod.value) == false) {
          changeSelectedPaymentMethod(paymentService.mainMethod);
        }
      },
    );
    _displayTimer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimeRemainning());

    prefetchAuthAndQR();
    handleSse();
    super.onReady();
  }

  void changeSelectedPaymentMethod(PaymentMethod? paymentMethod) {
    _selectedPaymentMethod.value = paymentMethod;
    if (_selectedPaymentMethod.value != null && (authService.bioKey.key != null || authService.pin != null)) {
      _requestQR(_selectedPaymentMethod.value!);
    }
  }

  void handleSse() {
    payService.getTransactionStatusStream().onData(
      (data) {
        if (data == TransactionStatus.CONFIRMED) {
          showSuccessDialog();
        }
      },
    );
  }

  Future<bool> biometricAuth() async {
    try {
      final res = await localAuthService.bioAuth();

      if (res) {
        await authService.bioKey.loadBioKey();
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

  Future<void> _requestQR(PaymentMethod paymentMethod) async {
    _qrRefreshTimer?.cancel();
    timeRemaining.value = null;
    await payService.fetchPaymentToken(paymentMethod);
    updateTimeRemainning();
    reserveQRRefresh(payService.expireAt!);
  }

  Future<void> setBrightness(double brightness) async {
    try {
      _screenBrightness = await ScreenBrightness().system;
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> resetBrightness() async {
    if (_screenBrightness != null) {
      try {
        await ScreenBrightness().setScreenBrightness(_screenBrightness!);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> prefetchAuthAndQR() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (authService.bioKey.key == null) {
      await biometricAuth();
    }
    if (authService.bioKey.key == null && authService.pin == null) {
      await showPinDialog();
    }
    if (authService.bioKey.key == null && authService.pin == null) {
      return;
    }
    if (_selectedPaymentMethod.value != null) {
      await _requestQR(_selectedPaymentMethod.value!);
    }
  }

  Future<void> requestAuthAndQR() async {
    if (_selectedPaymentMethod.value == null) {
      return;
    }
    if (authService.bioKey.key == null) {
      await biometricAuth();
    }
    if (authService.bioKey.key == null && authService.pin == null) {
      await showPinDialog();
    }
    if (authService.bioKey.key == null && authService.pin == null) {
      return;
    }
    await _requestQR(_selectedPaymentMethod.value!);
  }

  void reserveQRRefresh(DateTime refreshAt, {bool recursive = true}) {
    Duration awaitTime = refreshAt.difference(DateTime.now());
    _qrRefreshTimer = Timer(awaitTime, () async {
      timeRemaining.value = null;
      await payService.fetchPaymentToken(_selectedPaymentMethod.value!);
      updateTimeRemainning();

      if (recursive) {
        reserveQRRefresh(payService.expireAt!);
      }
    });
  }

  void updateTimeRemainning() {
    if (payService.expireAt == null || _selectedPaymentMethod.value == null || Get.currentRoute != Routes.HOME) {
      timeRemaining.value = null;
      return;
    }

    setBrightness(1);
    timeRemaining.value = payService.expireAt!.difference(DateTime.now());
  }

  openKakaoChannelTalk() async {
    try {
      await launchBrowserTab(Uri.parse('https://pf.kakao.com/_gHxlCxj/chat?app_key=1127bc4e0b146e5579b6d6a2ad8d0ad1&kakao_agent=sdk%2F1.4.2+sdk_type%2Fflutter+os%2Fandroid-34+lang%2Fko-KR+origin%2FVNmybeVuZKt9uPyjMrvJ04STxtI%3D+device%2FA065+android_pkg%2Fcom.develop.dimipay+app_ver%2F1.1.0&api_ver=1.0'));
    } catch (error) {
      PlatformException exception = (error as PlatformException);
      if (exception.code != "CANCELED") {
        DPErrorSnackBar().open("카카오톡을 통한 문의 채널 연결에 실패하였습니다.");
      }
    }
  }

  @override
  Future<void> onClose() async {
    _displayTimer.cancel();
    _qrRefreshTimer?.cancel();
    await resetBrightness();
    super.onClose();
  }
}
