import 'dart:async';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:get/get.dart';

class PushRepository {
  final ApiProvider api;

  PushRepository({ApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<void> updateFcmToken(String token) async {
    String url = "/fcm";
    Map<String, dynamic> data = {'token': token};
    await api.put(url, data: data);
  }
}
