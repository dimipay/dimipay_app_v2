import 'dart:async';
import 'dart:developer';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/model.dart';
import 'package:dimipay_app_v2/app/services/pay/repository.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PayService extends GetxController with StateMixin<String> {
  final PayRepository repository;
  PayService({PayRepository? repository}) : repository = repository ?? PayRepository();

  final AuthService authService = Get.find<AuthService>();

  final Rx<String?> _paymentToken = Rx(null);
  String? get paymentToken => _paymentToken.value;

  StreamController<TransactionStatus> statusStreamController = StreamController.broadcast();

  DateTime? expireAt;

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
  void onInit() async {
    super.onInit();
    _connectTransactionStatusStream();
  }

  Future<void> fetchPaymentToken(PaymentMethod paymentMethod) async {
    try {
      change(null, status: RxStatus.loading());
      _paymentToken.value = null;
      expireAt = null;
      Map res = await repository.getPaymentToken(paymentMethod: paymentMethod, pin: authService.pin, bioKey: authService.bioKey.key);
      _paymentToken.value = res['code'];
      expireAt = DateTime.parse(res['expiresAt']);
      change(_paymentToken.value, status: RxStatus.success());
    } on DioException catch (e) {
      log(e.response!.data.toString());
    }
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
