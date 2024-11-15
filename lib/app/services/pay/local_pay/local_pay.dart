import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:base45/base45.dart';
import 'package:cryptography/cryptography.dart';

class LocalPay {
  final List<int> payloadFormatIndicator = [0x4c, 0x50];
  final List<int> applicationIdentifier = [0x44, 0x50, 0xff, 0xff];
  final List<int> version = [0x12];
  final List<int> authType = [0x18];
  final int tx = 30;

  late final List<int> userIdentifier;
  late final List<int> deviceIdentifier;
  late final List<int> authToken;
  late final List<int> key;

  LocalPay({
    required String userIdentifier,
    required String deviceIdentifier,
    required String authToken,
    required String key,
  }) {
    this.userIdentifier = parseStringIdentifier(userIdentifier);
    this.deviceIdentifier = parseStringIdentifier(deviceIdentifier);
    this.authToken = parseStringIdentifier(authToken);
    this.key = parseStringIdentifier(key);
  }

  List<int> parseStringIdentifier(String identifier) {
    List<int> res = [];

    identifier = identifier.replaceAll('-', '');

    for (var i = 0; i < identifier.length; i += 2) {
      res.add(int.parse(identifier[i] + identifier[i + 1], radix: 16));
    }
    return res;
  }

  Future<List<int>> calcHmac(List<int> authToken, int c) async {
    final algorithm = Hmac.sha256();
    final secretKey = SecretKey(authToken);

    Uint8List encodedC = utf8.encode(c.toString());

    Mac mac = await algorithm.calculateMac(encodedC, secretKey: secretKey);
    return mac.bytes;
  }

  List<int> generateRandomBytes(int length) {
    List<int> res = [];
    for (int i = 0; i < length; i++) {
      res.add(Random().nextInt(256));
    }
    return res;
  }

  List<int> generateNonce() {
    return generateRandomBytes(16);
  }

  List<int> generateIv() {
    return generateRandomBytes(12);
  }

  Future<List<int>> encrypt(List<int> payload, [List<int>? iv]) async {
    final algorithm = AesGcm.with128bits();
    final secretKey = SecretKey(key);
    final nonce = iv ?? algorithm.newNonce();

    final secretBox = await algorithm.encrypt(
      payload,
      secretKey: secretKey,
      nonce: nonce,
    );
    return [nonce.length] + nonce + secretBox.mac.bytes + secretBox.cipherText;
  }

  Future<List<int>> createEncryptedPayload(
    int paymentMethodIdentifier,
    int t,
    int t0, [
    String? nonce,
    String? iv,
  ]) async {
    int c = (t - t0) ~/ tx;
    List<int> hmac = await calcHmac(authToken, c);

    late final List<int> parsedNonce;
    if (nonce == null) {
      parsedNonce = generateNonce();
    } else {
      parsedNonce = parseStringIdentifier(nonce);
    }

    late final List<int> parsedIv;
    if (iv == null) {
      parsedIv = generateIv();
    } else {
      parsedIv = parseStringIdentifier(iv);
    }

    List<int> payload = deviceIdentifier + [paymentMethodIdentifier] + hmac + parsedNonce;

    return await encrypt(payload, parsedIv);
  }

  List<int> createMetaData() {
    return payloadFormatIndicator + applicationIdentifier + version;
  }

  List<int> createCommonPayload() {
    return authType + userIdentifier;
  }

  void printBytes(List<int> bytes) {
    for (var byte in bytes) {
      stdout.write('${byte.toRadixString(16)} ');
    }
  }

  Future<String> generateLocalPayToken({
    required int paymentMethodIdentifier,
    required int paymentMethodCreatedAt,
    int? generateTime,
    String? nonce,
    String? iv,
  }) async {
    generateTime ??= DateTime.now().toLocal().millisecondsSinceEpoch ~/ 1000;

    List<int> metaData = createMetaData();
    List<int> commonPayload = createCommonPayload();
    List<int> encryptedPayload = await createEncryptedPayload(paymentMethodIdentifier, generateTime, paymentMethodCreatedAt, nonce, iv);

    List<int> payload = metaData + commonPayload + encryptedPayload;
    return Base45.encode(Uint8List.fromList(payload));
  }
}
