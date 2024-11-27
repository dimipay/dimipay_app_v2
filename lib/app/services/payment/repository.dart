import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/enc.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/from_cache.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/save_cache.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:get/instance_manager.dart';

class PaymentRepository {
  final ApiProvider api;

  PaymentRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Map> getPaymentMethodFromCache() async {
    String url = '/payments/methods';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [FromCache()]);

    String? mainMethodId = response.data["mainMethodId"];
    List<PaymentMethod> paymentMethods = (response.data["methods"] as List).map((e) => PaymentMethod.fromJson(e)).toList();

    return {"mainMethodId": mainMethodId, "paymentMethods": paymentMethods};
  }

  Future<void> saveCurrentPaymentMethodsToCache(
    List<PaymentMethod> paymentMethods,
    PaymentMethod? mainPaymentMethod,
  ) async {
    String url = '/payments/methods';
    HttpCacheService cacheService = Get.find<HttpCacheService>();

    Map<String, dynamic> data = {
      'mainMethodId': mainPaymentMethod?.id,
      'methods': paymentMethods.map((e) => e.toJson()).toList(),
    };

    await cacheService.save(
        DPHttpRequest(url, method: 'GET'),
        DPHttpResponse(
          code: 'OK',
          statusCode: 200,
          timeStamp: DateTime.now().toString(),
          data: data,
        ));
  }

  Future<Map> getPaymentMethod() async {
    String url = '/payments/methods';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT(), SaveCache()]);

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
      DPHttpResponse response = await api.post(DPHttpRequest(url, body: body), [JWT(), EncryptBody()]);
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

    await api.patch(DPHttpRequest(url, body: body), [JWT()]);
  }

  Future<void> patchMainMethod({required String id}) async {
    String url = '/payments/methods/main/$id';
    await api.patch(DPHttpRequest(url), [JWT()]);
  }

  Future<void> deletePaymentMethod({required String id}) async {
    String url = '/payments/methods/$id';
    await api.delete(DPHttpRequest(url), [JWT()]);
  }
}
