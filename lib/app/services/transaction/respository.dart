import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class TransactionRepository {
  final ApiProvider api;

  TransactionRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Map> getTransactions(DateTime? offset, {int limit = 15}) async {
    String url = '/transaction';
    Map<String, dynamic> queryParameter = {"limit": limit};

    if (offset != null) {
      queryParameter["offset"] = offset.toIso8601String();
    }

    Response response = await api.get(url, queryParameters: queryParameter);
    List<Transaction> transactions = response.data["history"].map<Transaction>((json) {
      return Transaction.fromJson(json);
    }).toList();
    return {"transactions": transactions, "next": response.data["next"]};
  }
}
