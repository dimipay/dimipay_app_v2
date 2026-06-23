import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/export.dart';

class RsaKeyPair {
  final String publicKey;
  final String privateKey;

  const RsaKeyPair({
    required this.publicKey,
    required this.privateKey,
  });
}

class RsaManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  RsaKeyPair? _key;
  RsaKeyPair? get key => _key;

  Future<RsaManager> init() async {
    String? publicKey = await _storage.read(key: 'rsaPublicKey');
    String? privateKey = await _storage.read(key: 'rsaPrivateKey');

    if (publicKey != null && privateKey != null) {
      _key = RsaKeyPair(publicKey: publicKey, privateKey: privateKey);
    }

    return this;
  }

  Future<void> setKey(RsaKeyPair newKey) async {
    _key = newKey;

    await _storage.write(
        key: 'rsaPublicKey',
        value: newKey.publicKey.replaceAll('\n', '\\r\\n'));
    await _storage.write(key: 'rsaPrivateKey', value: newKey.privateKey);
  }

  static Future<RsaKeyPair> generateRSAKeyPair() async {
    final keyGenerator = RSAKeyGenerator()
      ..init(
        ParametersWithRandom(
          RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64),
          _secureRandom(),
        ),
      );

    final pair = keyGenerator.generateKeyPair();
    final publicKey = pair.publicKey as RSAPublicKey;
    final privateKey = pair.privateKey as RSAPrivateKey;

    return RsaKeyPair(
      publicKey: _encodePublicKeyToPkcs1Pem(publicKey),
      privateKey: _encodePrivateKeyToPkcs8Pem(privateKey),
    );
  }

  Future<void> clear() async {
    await _storage.delete(key: 'rsaPublicKey');
    await _storage.delete(key: 'rsaPrivateKey');

    _key = null;
  }

  static SecureRandom _secureRandom() {
    final random = Random.secure();
    final seed = Uint8List.fromList(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );

    return FortunaRandom()..seed(KeyParameter(seed));
  }

  static String _encodePublicKeyToPkcs1Pem(RSAPublicKey publicKey) {
    final publicKeySequence = ASN1Sequence()
      ..add(ASN1Integer(publicKey.modulus!))
      ..add(ASN1Integer(publicKey.exponent!));

    return _pem('RSA PUBLIC KEY', publicKeySequence.encodedBytes);
  }

  static String _encodePrivateKeyToPkcs8Pem(RSAPrivateKey privateKey) {
    final algorithmIdentifier = ASN1Sequence()
      ..add(ASN1ObjectIdentifier.fromComponentString('1.2.840.113549.1.1.1'))
      ..add(ASN1Null());

    final privateKeyInfo = ASN1Sequence()
      ..add(ASN1Integer(BigInt.zero))
      ..add(algorithmIdentifier)
      ..add(ASN1OctetString(_encodePrivateKeyToPkcs1Der(privateKey)));

    return _pem('PRIVATE KEY', privateKeyInfo.encodedBytes);
  }

  static Uint8List _encodePrivateKeyToPkcs1Der(RSAPrivateKey privateKey) {
    final p = privateKey.p!;
    final q = privateKey.q!;
    final d = privateKey.privateExponent!;
    final dP = d % (p - BigInt.one);
    final dQ = d % (q - BigInt.one);
    final qInv = q.modInverse(p);

    final privateKeySequence = ASN1Sequence()
      ..add(ASN1Integer(BigInt.zero))
      ..add(ASN1Integer(privateKey.modulus!))
      ..add(ASN1Integer(privateKey.publicExponent!))
      ..add(ASN1Integer(d))
      ..add(ASN1Integer(p))
      ..add(ASN1Integer(q))
      ..add(ASN1Integer(dP))
      ..add(ASN1Integer(dQ))
      ..add(ASN1Integer(qInv));

    return privateKeySequence.encodedBytes;
  }

  static String _pem(String label, Uint8List der) {
    final base64Der = base64.encode(der);
    final chunks = <String>[];

    for (var i = 0; i < base64Der.length; i += 64) {
      chunks.add(
        base64Der.substring(
          i,
          min(i + 64, base64Der.length),
        ),
      );
    }

    return '-----BEGIN $label-----\n'
        '${chunks.join('\n')}\n'
        '-----END $label-----';
  }
}
