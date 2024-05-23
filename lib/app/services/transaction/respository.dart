import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:get/instance_manager.dart';

class TransactionRepository {
  final ApiProvider api;

  TransactionRepository({ApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<Map> getTransactions(DateTime? offset, {int limit = 15}) async {
    String url = '/transaction';
    Map<String, dynamic> queryParameter = {"limit": limit};

    if (offset != null) {
      queryParameter["offset"] = offset.toIso8601String();
    }

    DPHttpResponse response = await api.get(url, queryParameters: queryParameter);
    List<Transaction> transactions = response.data["history"].map<Transaction>((json) {
      return Transaction.fromJson(json);
    }).toList();
    return {"transactions": transactions, "next": response.data["next"]};
  }
}
