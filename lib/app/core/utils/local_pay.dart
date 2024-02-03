// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dimipay_app_v2/app/core/utils/secret_method.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

class LocalPay {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final PREFIX = "4450"; // 4450 means DP in ASCII
  final Tx = 30;

  String userUuid = "";
  String deviceUuid = "";
  String methodId = "";
  String publicKey = "";
  String otpSecret = "";
  String t0 = "";

  String AlgorithmVersion = "";
  void init() async {
    // Get Algorithm Version
    getAlgorithmVersion();
    // Get Data
    getData();
  }

  void getData() async {
    userUuid = await _storage.read(key: 'userUid') ?? "";
    deviceUuid = await _storage.read(key: 'deviceUid') ?? "";
    methodId = await _storage.read(key: 'methodId') ?? "";
    publicKey = await _storage.read(key: 'publicKey') ?? "";
    otpSecret = await _storage.read(key: 'otpSecret') ?? "";
    t0 = await _storage.read(key: 't0') ?? "";
  }

  void getAlgorithmVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String versionBinary = int.parse(version).toRadixString(2).padLeft(5, '0');
    String buildNumberBinary = int.parse(buildNumber).toRadixString(2).padLeft(3, '0');
    AlgorithmVersion = versionBinary + buildNumberBinary;
  }

  int calcCounter(int T0) {
    // Unix Time
    int T = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int counter = (T - T0) ~/ Tx;
    return counter;
  }

  String calcHMAC() {
    List<int> K = utf8.encode(otpSecret);
    int calcC = calcCounter(int.parse(t0));
    List<int> C = utf8.encode(calcC.toString());
    final digest = Hmac(sha256, K).convert(C);
    return digest.toString();
  }

  String createNonce() {
    return const Uuid().v4();
  }

  Future<String> createEncrypt() async {
    String HMAC = calcHMAC();
    String data = deviceUuid + methodId + HMAC + createNonce();
    String encrypted = await doEncrypt(data, publicKey);
    return encrypted;
  }

  Future<String> createLocalPayload() async {
    String encrypted = await createEncrypt();
    String payload = PREFIX + AlgorithmVersion + userUuid + encrypted;
    return const Base64Codec().encode(utf8.encode(payload));
  }
}
