import 'dart:developer';

import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class PaymentRepository {
  final ApiProvider api;

  PaymentRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Map> getPaymentMethod({bool includeMainMethod = true}) async {
    String url = '/payment/method';
    Response response = await api.get(url, queryParameters: {"includeMainMethod": includeMainMethod});

    log(response.data.toString());

    String? mainMethodId = response.data["mainMethodId"];
    List<PaymentMethod> paymentMethods = (response.data["paymentMethods"] as List).map((e) => PaymentMethod.fromJson(e)).toList();

    return {"mainMethodId": mainMethodId, "paymentMethods": paymentMethods};
  }

  Future<void> createPaymentMethod(
      {required String name,
      required String number,
      required String year,
      required String month,
      required String idNo,
      required String pw,
      required String ownerName}) async {
    String url = '/payment/method';
    Map body = {"name": name, "number": number, "year": year, "month": month, "idNo": idNo, "pw": pw, "ownerName": ownerName};

    try {
      await api.post(url, data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> patchPaymentMethod({
    required String id,
    required String name,
    required String color,
    required String ownerName,
  }) async {
    String url = '/payment/method';
    Map body = {"id": id, "name": name, "color": color, "ownerName": ownerName};

    try {
      await api.patch(url, data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<void> deletePaymentMethod({required String id}) async {
    String url = '/payment/method';
    Map body = {"id": id};
    try {
      await api.delete(url, data: body);
    } on DioException catch (e) {
      rethrow;
    }
  }
}
