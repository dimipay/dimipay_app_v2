import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:dimipay_app_v2/app/services/pay/local_pay/tlv.dart';
import 'package:uuid/parsing.dart';
import 'package:uuid/v7.dart';

enum AuthType {
  notAuthed(0x00),
  byPass(0x01),
  localAuth(0x10),
  bioAuth(0x18),
  pinAuth(0x21);

  const AuthType(this.byteCode);

  final int byteCode;
}

class LocalPay {
  final Uint8List payloadFormatIndicator = Uint8List.fromList([0x4c, 0x50]);
  final Uint8List applicationIdentifier = Uint8List.fromList([0x44, 0x50, 0xff, 0xff]);
  final Uint8List version = Uint8List.fromList([0x04]);
  final int tx = 30;

  late final Uint8List userIdentifier;
  late final Uint8List deviceIdentifier;
  late final Uint8List authToken;
  late final Uint8List rk;

  LocalPay({
    required this.userIdentifier,
    required this.deviceIdentifier,
    required this.authToken,
    required this.rk,
  });

  Future<Uint8List> generateLocalPayToken({
    required int paymentMethodIdentifier,
    required int t0,
    required int authType,
    int? t,
    Uint8List? nonce,
  }) async {
    final metadataPayload = buildMetaDataPayload();
    final commonPayload = buildCommonPayload(paymentMethodIdentifier, authType);
    final rawPrivatePayload = buildRawPrivatePayload(nonce);

    final encryptedPrivatePayload = await encryptPrivatePayload(metadataPayload, commonPayload, rawPrivatePayload, t0, t);
    final tokenBuilder = BytesBuilder();
    tokenBuilder.add(metadataPayload);
    tokenBuilder.add(commonPayload);
    tokenBuilder.add(encryptedPrivatePayload);

    return tokenBuilder.takeBytes();
  }

  Uint8List buildMetaDataPayload() {
    final builder = BytesBuilder();
    builder.add(payloadFormatIndicator);
    builder.add(applicationIdentifier);
    builder.add(version);
    return builder.takeBytes();
  }

  Uint8List buildCommonPayload(int paymentMethodIdentifier, int authType) {
    final builder = BytesBuilder();

    final authTypeTLV = TLV(Tag.authType, Uint8List.fromList([authType]));
    final userIdentifierTLV = TLV(Tag.userIdentifier, userIdentifier);
    final paymentMethodIdentifierTlV = TLV(Tag.paymentMethodIdentifier, Uint8List.fromList([paymentMethodIdentifier]));

    final payloadLengthIndicatorTLV = createPayloadLengthInicator([authTypeTLV, userIdentifierTLV, paymentMethodIdentifierTlV]);

    builder.add(payloadLengthIndicatorTLV.bytes);
    builder.add(authTypeTLV.bytes);
    builder.add(userIdentifierTLV.bytes);
    builder.add(paymentMethodIdentifierTlV.bytes);

    return builder.takeBytes();
  }

  Uint8List buildRawPrivatePayload(Uint8List? nonce) {
    nonce ??= generateNonce();

    final TLV authTokenTLV = TLV(Tag.authToken, authToken);
    final TLV deviceIdentifierTLV = TLV(Tag.deviceIdentifier, deviceIdentifier);
    final TLV nonceTLV = TLV(Tag.nonce, nonce);
    final TLV payloadLengthIndicator = createPayloadLengthInicator([authTokenTLV, deviceIdentifierTLV, nonceTLV]);

    final builder = BytesBuilder();
    builder.add(payloadLengthIndicator.bytes);
    builder.add(authTokenTLV.bytes);
    builder.add(deviceIdentifierTLV.bytes);
    builder.add(nonceTLV.bytes);

    return builder.takeBytes();
  }

  Future<Uint8List> encryptPrivatePayload(Uint8List metadataPayload, Uint8List commonPayload, Uint8List rawPrivatePayload, int t0, [int? t]) async {
    t ??= DateTime.now().toLocal().millisecondsSinceEpoch;
    final (k, n) = await prepareKey(t, t0, rk, userIdentifier);

    final aad = Uint8List.fromList(metadataPayload + commonPayload);
    return xchacha20Poly1305(rawPrivatePayload, k, n, aad);
  }

  Future<Uint8List> xchacha20Poly1305(List<int> message, List<int> key, List<int> nonce, List<int> aad) async {
    final xchacha20 = Xchacha20.poly1305Aead();
    final secretKey = SecretKey(key);

    final xchacha20res = await xchacha20.encrypt(
      message,
      secretKey: secretKey,
      nonce: nonce,
      aad: aad,
    );

    final res = Uint8List(message.length + 16);

    res.setAll(0, xchacha20res.cipherText);
    res.setAll(message.length, xchacha20res.mac.bytes);

    return res;
  }

  Future<(Uint8List, Uint8List)> prepareKey(int t, int t0, Uint8List rk, Uint8List userIdentifier) async {
    final hkdf = Hkdf(hmac: Hmac.sha384(), outputLength: 56);

    final c = calculateCounter(t, t0);

    final ikm = SecretKey(rk);
    final info = utf8.encode('local-generated-payment-token$c');
    final salt = userIdentifier;
    final tmp = await hkdf.deriveKey(
      secretKey: ikm,
      info: info,
      nonce: salt,
    );
    final byteTmp = Uint8List.fromList(tmp.bytes);

    final k = Uint8List(32);
    final n = Uint8List(24);

    k.setAll(0, byteTmp.getRange(0, 32));
    n.setAll(0, byteTmp.getRange(32, 56));

    return (k, n);
  }

  int calculateCounter(int t, int t0) {
    return (t - t0) ~/ (tx * 1000);
  }

  TLV createPayloadLengthInicator(List<TLV> tlvs) {
    int totalLenth = tlvs.fold(0, (acc, tlv) => acc + tlv.bytes.length);
    return TLV(Tag.payloadLengthIndicator, Uint8List.fromList([totalLenth]));
  }

  Uint8List generateNonce() {
    final uuidv7 = const UuidV7().generate();
    return UuidParsing.parseAsByteList(uuidv7);
  }
}

String uint8ListToHex(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}
