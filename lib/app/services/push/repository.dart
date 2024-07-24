import 'dart:async';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PushRepository {
  final ApiProvider api;
  final String _hiveBoxName = 'pushService';
  late final Box _hiveBox;

  Future<void> _initHiveBox() async {
    _hiveBox = await Hive.openBox(_hiveBoxName);
  }

  PushRepository({ApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<void> init() async {
    await _initHiveBox();
  }

  Future<void> updateFcmTokenToServer(String token) async {
    String url = "/fcm";
    Map<String, dynamic> data = {'token': token};
    await api.put(url, data: data);
  }

  Future<DateTime?> getTokenLastUpdated() async {
    return await _hiveBox.get('pushTokenLastUpdated');
  }

  Future<void> setTokenLastUpdated(DateTime tokenLastUpdated) async {
    await _hiveBox.put('pushTokenLastUpdated', tokenLastUpdated);
  }

  Future<void> deleteTokenLastUpdated() async {
    await _hiveBox.delete('pushTokenLastUpdated');
  }
}
