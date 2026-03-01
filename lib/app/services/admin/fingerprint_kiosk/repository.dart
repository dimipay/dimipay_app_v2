import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FingerprintKioskRepository {
  final ApiProvider api;

  FingerprintKioskRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();

  Future<FingerprintPasscode> generatePasscode({required int life}) async {
    String url = '/admin/fingerprint/passcode';
    DPHttpResponse response = await api.get(
      DPHttpRequest(url, queryParameters: {'life': life}),
      [JWT()],
    );
    return FingerprintPasscode.fromJson(response.data);
  }
}
