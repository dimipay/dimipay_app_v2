import 'dart:convert';
import 'dart:typed_data';
import 'package:base45/base45.dart';
import 'package:cryptography/cryptography.dart';
import 'dart:math' as math;
import 'package:uuid/v7.dart';

class Bytes {
  List<int> bytes = [];

  Bytes(this.bytes);

  Bytes.fromString(String str) {
    bytes = [];

    for (var i = 0; i < str.length; i += 2) {
      bytes.add(int.parse(str[i] + str[i + 1], radix: 16));
    }
  }

  @override
  String toString() {
    String res = "";
    for (var byte in bytes) {
      res += '${byte.toRadixString(16)} ';
    }
    return res;
  }

  Bytes operator +(Bytes other) {
    return Bytes([...bytes, ...other.bytes]);
  }
}

enum TlvTagType {
  authType,
  authToken,
  userIdentifier,
  deviceIdentifier,
  paymentMethodIdentifier,
  nonce,
  payloadLengthIndicator,
  additionalData,
}

class Tlv {
  final TlvTagType t;
  final Bytes v;
  Tlv(this.t, this.v);

  int get tValue => t.index + 1;

  Bytes get tlv {
    final l = math.log(v.bytes.length) ~/ math.log(2);
    final tl = (tValue << 4) + l;
    return Bytes([tl] + v.bytes);
  }
}

class LocalPay {
  final Bytes payloadFormatIndicator = Bytes([0x4c, 0x50]);
  final Bytes applicationIdentifier = Bytes([0x44, 0x50, 0xff, 0xff]);
  final Bytes version = Bytes([0x42]);
  final Bytes authType = Bytes([0x10]);
  final int tx = 30;

  late final Bytes userIdentifier;
  late final Bytes deviceIdentifier;
  late final Bytes authToken;
  late final Bytes rk;

  LocalPay({
    required String userIdentifier,
    required String deviceIdentifier,
    required String authToken,
    required String rk,
  }) {
    this.userIdentifier = Bytes.fromString(userIdentifier.replaceAll('-', ''));
    this.deviceIdentifier = Bytes.fromString(deviceIdentifier.replaceAll('-', ''));
    this.authToken = Bytes.fromString(authToken.replaceAll('-', ''));
    this.rk = Bytes.fromString(rk.replaceAll('-', ''));
  }

  Bytes generateNonce() {
    return Bytes.fromString(const UuidV7().generate().replaceAll('-', ''));
  }

  Future<Bytes> encryptPrivatePayload(Bytes metaDataPayload, Bytes commonPayload, Bytes privatePayload, int t0, [int? t]) async {
    t ??= DateTime.now().toLocal().millisecondsSinceEpoch ~/ 1000;

    int c = (t - t0) ~/ tx;
    final hkdf = Hkdf(hmac: Hmac.sha384(), outputLength: 56);
    final ikm = SecretKey(rk.bytes);
    final info = utf8.encode('local-generated-payment-token$c');
    final salt = userIdentifier.bytes;
    final tmp = (await hkdf.deriveKey(
      secretKey: ikm,
      nonce: salt,
      info: info,
    ))
        .bytes;

    final k = tmp.getRange(0, 32).toList();
    final n = tmp.getRange(32, tmp.length).toList();

    final xchacha20 = Xchacha20.poly1305Aead();
    final secretKey = SecretKey(k);

    final xchacha20res = await xchacha20.encrypt(
      privatePayload.bytes,
      secretKey: secretKey,
      nonce: n,
      aad: metaDataPayload.bytes + commonPayload.bytes + privatePayload.bytes,
    );

    print(Bytes(k));
    print(Bytes(n));
    print(Bytes(xchacha20res.cipherText));

    return Bytes(xchacha20res.cipherText);
  }

  Tlv createPaymentLengthInicator(List<Tlv> tlvs) {
    int totalLenth = 0;
    for (var tlv in tlvs) {
      totalLenth += tlv.tlv.bytes.length;
    }
    return Tlv(TlvTagType.payloadLengthIndicator, Bytes([totalLenth]));
  }

  Bytes createMetaData() {
    return payloadFormatIndicator + applicationIdentifier + version;
  }

  Bytes createCommonPayload(int paymentMethodIdentifier) {
    final authTypeTlv = Tlv(TlvTagType.authType, authType);
    final userIdentifierTlv = Tlv(TlvTagType.userIdentifier, userIdentifier);
    final paymentMethodIdentifierTlv = Tlv(TlvTagType.paymentMethodIdentifier, Bytes([paymentMethodIdentifier]));
    final paymentLengthIndicator = createPaymentLengthInicator([authTypeTlv, userIdentifierTlv, paymentMethodIdentifierTlv]);

    return paymentLengthIndicator.tlv + authTypeTlv.tlv + userIdentifierTlv.tlv + paymentMethodIdentifierTlv.tlv;
  }

  Bytes createPrivatePayload(
    int t0, [
    int? t,
    String? nonce,
  ]) {
    final Bytes parsedNonce = nonce == null ? generateNonce() : Bytes.fromString(nonce.replaceAll('-', ''));

    Tlv authTokenTlv = Tlv(TlvTagType.authToken, authToken);
    Tlv deviceIdentifierTlv = Tlv(TlvTagType.deviceIdentifier, deviceIdentifier);
    Tlv nonceTlv = Tlv(TlvTagType.nonce, parsedNonce);
    Tlv paymentLengthIndicator = createPaymentLengthInicator([authTokenTlv, deviceIdentifierTlv, nonceTlv]);

    return paymentLengthIndicator.tlv + authTokenTlv.tlv + deviceIdentifierTlv.tlv + nonceTlv.tlv;
  }

  Future<String> generateLocalPayToken({
    required int paymentMethodIdentifier,
    required int paymentMethodCreatedAt,
    int? t,
    String? nonce,
  }) async {
    Bytes metaDataPayload = createMetaData();
    Bytes commonPayload = createCommonPayload(paymentMethodIdentifier);
    Bytes privatePayload = createPrivatePayload(paymentMethodCreatedAt, t, nonce);

    Bytes encryptedPrivatePayload = await encryptPrivatePayload(metaDataPayload, commonPayload, privatePayload, paymentMethodCreatedAt, t);
    return Base45.encode(Uint8List.fromList(metaDataPayload.bytes + commonPayload.bytes + encryptedPrivatePayload.bytes));
  }
}
