import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:base45/base45.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/local_pay/local_pay.dart';
import 'package:dimipay_app_v2/app/services/pay/model.dart';
import 'package:dimipay_app_v2/app/services/pay/repository.dart';
import 'package:dimipay_app_v2/app/services/pay/state.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:get/get.dart';
import 'package:uuid/parsing.dart';

class PayService extends GetxController {
  final PayRepository repository;
  PayService(this.repository);

  final Rx<PaymentTokenState> _paymentTokenState = Rx(const PaymentTokenInitial());
  PaymentTokenState get paymentTokenState => _paymentTokenState.value;

  StreamController<TransactionStatus> statusStreamController = StreamController.broadcast();

  Future<void> _connectTransactionStatusStream() async {
    final statusStream = await repository.getTransactionStatus();
    statusStream.listen(
          (event) {
        statusStreamController.add(event);
      },
      onDone: () {
        if (statusStreamController.isClosed) {
          return;
        }
        _connectTransactionStatusStream();
      },
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _connectTransactionStatusStream();
  }

  (AuthType authType, Uint8List authToken) getAuthInfo() {
    final AuthService authService = Get.find<AuthService>();
    if (authService.otp != null) {
      Uint8List base64Otp = base64.decode(authService.otp!);
      return (AuthType.pinAuth, base64Otp);
    } else {
      return (AuthType.bioAuth, UuidParsing.parseAsByteList(authService.bioKey.key!));
    }
  }

  Future<void> generateLocalPaymentToken(PaymentMethod paymentMethod) async {
    try {
      final AuthService authService = Get.find<AuthService>();
      final UserService userService = Get.find<UserService>();
      _paymentTokenState.value = const PaymentTokenLoading();

      final (authType, authToken) = getAuthInfo();

      LocalPay localpay = LocalPay(
        userIdentifier: UuidParsing.parseAsByteList((userService.userState as UserStateSuccess).value.id, noDashes: true, validate: false),
        deviceIdentifier: UuidParsing.parseAsByteList(authService.deviceId.deviceId!, noDashes: true, validate: false),
        authToken: authToken,
        rk: authService.aes.key!,
      );

      final int currentTime = DateTime.now().toLocal().millisecondsSinceEpoch;
      final int t0 = paymentMethod.createdAt.toLocal().millisecondsSinceEpoch;
      final int counter = (currentTime - t0) ~/ (30 * 1000);

      final currentStepStartTime = t0 + (counter * 30 * 1000);
      final timeElapsedInStep = currentTime - currentStepStartTime;
      final timeLeftInStep = (30 * 1000) - timeElapsedInStep;

      Uint8List rawToken = await localpay.generateLocalPayToken(
        paymentMethodIdentifier: paymentMethod.sequence,
        t0: t0,
        t: currentTime,
        authType: authType.byteCode,
      );

      String encodedToken = Base45.encode(rawToken);
      _paymentTokenState.value = PaymentTokenSuccess(
        value: encodedToken,
        expireAt: DateTime.now().add(Duration(milliseconds: timeLeftInStep)),
        lifetime: Duration(milliseconds: timeLeftInStep),
      );
    } on Exception catch (e) {
      _paymentTokenState.value = PaymentTokenFailed(exception: e);
    }
  }

  void invalidateToken() {
    _paymentTokenState.value = const PaymentTokenInitial();
  }

  StreamSubscription<TransactionStatus> getTransactionStatusStream() {
    return statusStreamController.stream.listen(null);
  }

  @override
  void onClose() {
    statusStreamController.close();
    super.onClose();
  }
}