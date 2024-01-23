import 'dart:developer';

import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class TransactionRepository {
  final ApiProvider api;

  TransactionRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();

  Future<List<Transaction>> getTransactions() async {
    String url = '/transaction';
    Map<String, dynamic> queryParameter = {"offset": 0, "limit": 10};
    Response response = await api.get(url, queryParameters: queryParameter);
    log(response.data.toString());
    return response.data["history"].map<Transaction>((json) {
      log(json.toString());
      return Transaction.fromJson(json);
    }).toList();
  }
}
