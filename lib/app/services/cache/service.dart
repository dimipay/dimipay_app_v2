import 'dart:convert';
import 'dart:developer';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheNotExistException implements Exception {
  final String key;

  CacheNotExistException({required this.key});
}

class HttpCacheService extends GetxService {
  late final Box _hiveBox;

  HttpCacheService(this._hiveBox);

  String generateKey(DPHttpRequest request) {
    String path = request.path;
    List queryParameters = [];
    for (var element in request.queryParameters.entries) {
      queryParameters.add('${element.key}=${element.value}');
    }
    String fullQueryParameters = queryParameters.join('&');
    return '[${request.method}]$path?$fullQueryParameters';
  }

  String get(DPHttpRequest request) {
    String key = generateKey(request);
    String? value = _hiveBox.get(key);
    if (value == null) {
      log('No cache exist in $key');
      throw CacheNotExistException(key: key);
    }
    return value;
  }

  Future<void> save(DPHttpRequest request, DPHttpResponse response) async {
    String key = generateKey(request);

    String encodedData = json.encode(response.data);
    await _hiveBox.put(key, encodedData);
  }

  Future<void> clear() async {
    await _hiveBox.clear();
  }
}
