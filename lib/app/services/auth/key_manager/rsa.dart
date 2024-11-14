import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RsaManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  KeyPair? _key;
  KeyPair? get key => _key;

  Future<RsaManager> init() async {
    String? publicKey = await _storage.read(key: 'rsaPublicKey');
    String? privateKey = await _storage.read(key: 'rsaPrivateKey');

    if (publicKey != null && privateKey != null) {
      _key = KeyPair(publicKey, privateKey);
    }

    return this;
  }

  Future<void> setKey(KeyPair newKey) async {
    _key = newKey;

    await _storage.write(key: 'rsaPublicKey', value: newKey.publicKey);
    await _storage.write(key: 'rsaPrivateKey', value: newKey.privateKey);
  }

  static Future<KeyPair> generateRSAKeyPair() async {
    KeyPair keyPair = await RSA.generate(2048);
    final pkcs1PubKey = await RSA.convertPublicKeyToPKCS1(keyPair.publicKey);
    final pkcs8PrivKey = await RSA.convertPrivateKeyToPKCS8(keyPair.privateKey);
    return KeyPair(pkcs1PubKey, pkcs8PrivKey);
  }

  Future<void> clear() async {
    await _storage.delete(key: 'rsaPublicKey');
    await _storage.delete(key: 'rsaPrivateKey');

    _key = null;
  }
}
