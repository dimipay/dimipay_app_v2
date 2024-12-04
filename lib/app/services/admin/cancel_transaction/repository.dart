import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:get/get.dart';

class CancelTransactionRepository {
  final ApiProvider api;

  CancelTransactionRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<void> cancelTransaction({required String transactionId}) async {
    String url = '/admin/cancel-transaction';

    Map body = {"transactionId": transactionId};

    await api.post(DPHttpRequest(url, body: body), [JWT()]);
  }
}
