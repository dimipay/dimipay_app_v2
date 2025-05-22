import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:get/instance_manager.dart';

class TransactionRepository {
  final ApiProvider api;

  TransactionRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<({dynamic monthTotal, dynamic nextCursor, List<Transaction> transactions})> getTransactions({required int year, required int month, String? cursor, int? limit}) async {
    String url = '/history';
    Map<String, dynamic> queryParameter = {'year': year, 'month': month};

    if (cursor != null) {
      queryParameter['cursor'] = cursor;
    }

    if (limit != null) {
      queryParameter['limit'] = limit;
    }

    DPHttpResponse response = await api.get(DPHttpRequest(url, queryParameters: queryParameter), [JWT()]);
    List<Transaction> transactions = [];
    for (final group in response.data['groups']) {
      for (final transaction in group['transactions']) {
        transactions.add(Transaction.fromJson(transaction));
      }
    }
    return (transactions: transactions, monthTotal: response.data['monthTotal'], nextCursor: response.data['nextCursor']);
  }

  Future<TransactionDetail> getTransactionDetail(String transactionId) async {
    String url = '/history/$transactionId';

    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT()]);
    return TransactionDetail.fromJson(response.data);
  }

  Future<TransactionDetail> createTransaction({
    required DateTime createdAt,
    required String status,
    required String transactionType,
    required String purchaseType,
    required int products,
    required PaymentMethod paymentMethod,
  }) async {
    String url = '/history';

    Map<String, dynamic> body = {
      'createdAt': createdAt.toUtc().toIso8601String(),
      'status': status,
      'statusMessage': '테스트 결제',
      'transactionType': transactionType,
      'purchaseType': purchaseType,
      'products': products,
      'paymentMethodId': paymentMethod.id,
    };

    DPHttpResponse response = await api.post(DPHttpRequest(url, body: body), [JWT()]);
    return TransactionDetail.fromJson(response.data);
  }
}
