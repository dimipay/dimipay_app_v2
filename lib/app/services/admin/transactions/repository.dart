import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class TransactionsRepository {
  final ApiProvider api;

  TransactionsRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<void> cancelTransaction({required String transactionId, required String reason}) async {
    String url = '/admin/transactions/cancel';

    Map body = {"transactionId": transactionId, "reason": reason};

    try {
      await api.post(DPHttpRequest(url, body: body), [JWT()]);
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_TRANSACTION_ALREADY_CANCELED') {
        throw TransactionAlreadyCanceled(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_TRANSACTION_NOT_CONFIRMED') {
        throw NoSellingPrice(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_UNABLE_TO_CANCEL_TRANSACTION') {
        throw UnableToCancelTransaction(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_TRANSACTION_NOT_FOUND') {
        throw TransactionNotFound(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_TRANSACTION_CANCEL_FAILED') {
        throw TransactionCancelFailed(message: e.response?.data['message']);
      }
      rethrow;
    }
  }
}
