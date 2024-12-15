import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  static NetworkService? _instance;

  factory NetworkService() {
    _instance ??= NetworkService._internal();
    return _instance!;
  }

  NetworkService._internal();

  final _isOnline = false.obs;
  bool get isOnline => _isOnline.value;

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('prod-next.dimipay.io');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<NetworkService> init() async {
    // 초기 연결 상태 확인
    final connectivityResult = await Connectivity().checkConnectivity();
    _isOnline.value = await checkInternetConnection();

    // 연결 상태 변화 모니터링
    Connectivity().onConnectivityChanged.listen((result) async {
      _isOnline.value = await checkInternetConnection();
    });

    return this;
  }
}