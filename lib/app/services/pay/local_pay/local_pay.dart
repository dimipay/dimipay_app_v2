import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:base45/base45.dart';
import 'package:cryptography/cryptography.dart';
import 'package:uuid/uuid.dart';

class LocalPay {
  List<int> payloadFormatIndicator = [0x44, 0x50]; // 4450 means DP in ASCII
  List<int> version = [0x12];
  List<int> authType = [0x18];
  final int tx = 30;

  late final List<int> userIdentifier;
  late final List<int> deviceIdentifier;
  late final List<int> authToken;
  final int t0;
  final String key;

  LocalPay({
    required String userIdentifier,
    required String deviceIdentifier,
    required String authToken,
    required this.t0,
    required this.key,
  }) {
    this.userIdentifier = parseStringIdentifier(userIdentifier);
    this.deviceIdentifier = parseStringIdentifier(deviceIdentifier);
    this.authToken = parseStringIdentifier(authToken);
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

  List<int> generateNonce() {
    return parseStringIdentifier(const Uuid().v4());
  }

  Future<List<int>> encrypt(List<int> payload, List<int> key, [List<int>? iv]) async {
    final algorithm = AesGcm.with256bits();
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
    String key,
    int t, [
    String? nonce,
  ]) async {
    int c = (t - t0) ~/ tx;
    List<int> hmac = await calcHmac(authToken, c);

    late final List<int> parsedNonce;
    if (nonce == null) {
      parsedNonce = generateNonce();
    } else {
      parsedNonce = parseStringIdentifier(nonce);
    }

    List<int> payload = deviceIdentifier + [paymentMethodIdentifier] + hmac + parsedNonce;
    return await encrypt(payload, key.codeUnits);
  }

  List<int> createMetaData() {
    return payloadFormatIndicator + version;
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
    int? t,
    String? nonce,
    String? iv,
  }) async {
    t ??= DateTime.now().toLocal().millisecondsSinceEpoch ~/ 1000;

    List<int> metaData = createMetaData();
    List<int> commonPayload = createCommonPayload();
    List<int> encryptedPayload = await createEncryptedPayload(paymentMethodIdentifier, key, t, nonce);

    List<int> payload = metaData + commonPayload + encryptedPayload;
    return Base45.encode(Uint8List.fromList(payload));
  }
}
