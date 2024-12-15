import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dimipay_app_v2/app/pages/home/widgets/pay_success.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/bio_auth/service.dart';
import 'package:dimipay_app_v2/app/services/network/service.dart';
import 'package:dimipay_app_v2/app/services/pay/model.dart';
import 'package:dimipay_app_v2/app/services/pay/service.dart';
import 'package:dimipay_app_v2/app/services/pay/state.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:dimipay_app_v2/app/services/push/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:screen_brightness/screen_brightness.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageController extends GetxController {
  final UserService userService = Get.find<UserService>();
  final PaymentService paymentService = Get.find<PaymentService>();
  final AuthService authService = Get.find<AuthService>();
  final PayService payService = Get.find<PayService>();
  final LocalAuthService localAuthService = Get.find<LocalAuthService>();
  final PushService pushService = Get.find<PushService>();
  final NetworkService networkService = Get.find<NetworkService>();

  final Rx<Duration?> timeRemaining = Rx(null);
  final Rx<PaymentMethod?> _selectedPaymentMethod = Rx(null);
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod.value;

  Timer? _qrRefreshTimer;
  double? _screenBrightness;

  bool selectedPaymentExists() {
    return (paymentService.paymentMethodsState as PaymentMethodsStateSuccess).value.contains(selectedPaymentMethod);
  }

  @override
  Future<void> onReady() async {
    handleSse();
    pushService.init().then(
          (_) {
        pushService.requestPushPermission();
      },
    );
    await Future.wait([
      userService.fetchUser(),
      paymentService.fetchPaymentMethods(),
    ]);
    paymentService.paymentStream.onData(
          (data) async {
        if (!selectedPaymentExists()) {
          changeSelectedPaymentMethod(paymentService.mainMethod);
        }
      },
    );
    _firstQrRequest();
    super.onReady();
  }

  Future<void> _firstQrRequest() async {
    if (paymentService.paymentMethodsState is! PaymentMethodsStateSuccess || (paymentService.paymentMethodsState as PaymentMethodsStateSuccess).value.isEmpty) {
      return;
    }
    _selectedPaymentMethod.value = paymentService.mainMethod;
    await Future.delayed(const Duration(milliseconds: 300));
    requestAuthAndQR();
  }

  void changeSelectedPaymentMethod(PaymentMethod? paymentMethod) {
    _selectedPaymentMethod.value = paymentMethod;
    payService.invalidateToken();
    _qrRefreshTimer?.cancel();

    if (selectedPaymentMethod == null) {
      return;
    }

    if (authService.bioKey.key == null && authService.pin == null) {
      return;
    }

    _generateQR(selectedPaymentMethod!);
  }

  void handleSse() {
    payService.getTransactionStatusStream().onData(
          (data) {
        if (data == TransactionStatus.CONFIRMED) {
          showSuccessDialog();
          payService.invalidateToken();
          _qrRefreshTimer?.cancel();
          authService.invalidateAuthToken();
        }
      },
    );
  }

  Future<void> _generateQR(PaymentMethod paymentMethod, {bool reserve = true}) async {
    _qrRefreshTimer?.cancel();
    await payService.generateLocalPaymentToken(paymentMethod);

    final token = payService.paymentTokenState;
    if (token is! PaymentTokenSuccess) {
      return;
    }

    if (reserve) {
      Duration remainTime = token.expireAt.difference(DateTime.now());
      _qrRefreshTimer = Timer(remainTime, () async {
        await payService.generateLocalPaymentToken(_selectedPaymentMethod.value!);
        _generateQR(paymentMethod);
      });
    }
  }

  Future<bool> bioAuth() async {
    if (authService.bioKey.key != null) {
      return true;
    }
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

  Future<bool> pinAuth() async {
    if (!networkService.isOnline) {
      return false;
    }

    if (authService.jwt.token.accessToken == null) {
      return false;
    }
    if (authService.pin != null) {
      return true;
    }
    String? pin = await showPinDialog();
    return pin != null;
  }

  Future<bool> requestAuth() async {
    bool bioAuthed = await bioAuth();
    if (bioAuthed) {
      return true;
    }

    bool pinAuthed = await pinAuth();
    if (pinAuthed) {
      return true;
    }
    return false;
  }

  Future<void> requestAuthAndQR() async {
    bool authed = await requestAuth();
    if (authed) {
      await _generateQR(selectedPaymentMethod!);
    }
  }

  Future<void> setBrightness(double brightness) async {
    if (Platform.isIOS) {
      return;
    }
    try {
      _screenBrightness = await ScreenBrightness().system;
      await ScreenBrightness().setScreenBrightness(brightness);
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> resetBrightness() async {
    if (Platform.isIOS) {
      return;
    }
    if (_screenBrightness != null) {
      try {
        await ScreenBrightness().setScreenBrightness(_screenBrightness!);
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> openKakaoChannelTalk() async {
    try {
      await launchUrl(Uri.parse('https://pf.kakao.com/_gHxlCxj/chat?app_key=1127bc4e0b146e5579b6d6a2ad8d0ad1&kakao_agent=sdk%2F1.4.2+sdk_type%2Fflutter+os%2Fandroid-34+lang%2Fko-KR+origin%2FVNmybeVuZKt9uPyjMrvJ04STxtI%3D+device%2FA065+android_pkg%2Fcom.develop.dimipay+app_ver%2F1.1.0&api_ver=1.0'));
    } on Exception catch (error) {
      PlatformException exception = error as PlatformException;
      if (exception.code != 'CANCELED') {
        DPErrorSnackBar().open('카카오톡을 통한 문의 채널 연결에 실패하였습니다.');
      }
    }
  }

  @override
  Future<void> onClose() async {
    _qrRefreshTimer?.cancel();
    await resetBrightness();
    super.onClose();
  }
}