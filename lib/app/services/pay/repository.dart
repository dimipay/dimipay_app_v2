import 'dart:async';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:get/instance_manager.dart';

class PayRepository {
  final ApiProvider api;

  PayRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Map> getPaymentToken({required PaymentMethod paymentMethod, String? pin, String? bioKey}) async {
    String url = '/payment/token';
    Map<String, String> body = {
      'id': paymentMethod.id,
    };
    if (pin != null) {
      body['pin'] = pin;
    } else if (bioKey != null) {
      body['bioKey'] = bioKey;
    }
    DPHttpResponse response = await api.post(url, data: body);
    return response.data;
  }
}
