import 'dart:async';
import 'dart:developer';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/repository.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class PayService extends GetxController with StateMixin<String> {
  final PayRepository repository;
  PayService({PayRepository? repository}) : repository = repository ?? PayRepository();

  final AuthService authService = Get.find<AuthService>();

  final Rx<String?> _paymentToken = Rx(null);
  String? get paymentToken => _paymentToken.value;

  DateTime? expireAt;

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
}
