import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:get/instance_manager.dart';

class PaymentRepository {
  final SecureApiProvider api;

  PaymentRepository({SecureApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<Map> getPaymentMethod() async {
    String url = '/payments/methods';
    DPHttpResponse response = await api.get(url);

    String? mainMethodId = response.data["mainMethodId"];
    List<PaymentMethod> paymentMethods = (response.data["methods"] as List).map((e) => PaymentMethod.fromJson(e)).toList();

    return {"mainMethodId": mainMethodId, "paymentMethods": paymentMethods};
  }

  Future<PaymentMethod> createPaymentMethod({required String number, required String expireYear, required String expireMonth, required String idNumber, required String password}) async {
    String url = '/payments/methods/general';
    Map body = {
      "number": number,
      "expireYear": expireYear,
      "expireMonth": expireMonth,
      "idNumber": idNumber,
      "password": password,
    };

    try {
      DPHttpResponse response = await api.post(url, data: body, encrypt: true);
      return PaymentMethod.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> patchPaymentMethod({
    required String id,
    required String name,
  }) async {
    String url = '/payments/methods/$id';
    Map body = {"name": name};

    await api.patch(url, data: body);
  }

  Future<void> patchMainMethod({required String id}) async {
    String url = '/payments/methods/main/$id';
    await api.patch(url);
  }

  Future<void> deletePaymentMethod({required String id}) async {
    String url = '/payments/methods/$id';
    await api.delete(url);
  }
}
