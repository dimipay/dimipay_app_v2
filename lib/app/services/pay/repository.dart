import 'dart:async';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:get/instance_manager.dart';

class PayRepository {
  final SecureApiProvider api;

  PayRepository({SecureApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<Map> getPaymentToken({required PaymentMethod paymentMethod, String? pin, String? bioKey}) async {
    String url = '/pay/legacy/${paymentMethod.id}';
    DPHttpResponse response = await api.get(url, needPinOTP: true);
    return response.data;
  }
}
