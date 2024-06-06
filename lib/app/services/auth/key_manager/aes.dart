import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AesManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Uint8List? _key;
  Uint8List? get key => _key;

  Future<AesManager> init() async {
    String? base64AesKey = await _storage.read(key: 'aesKey');
    if (base64AesKey != null) {
      _key = base64.decode(base64AesKey);
    }
    return this;
  }

  Future<void> setKey(Uint8List newKey) async {
    await _storage.write(key: 'aesKey', value: base64.encode(newKey));
    _key = newKey;
  }

  Future<void> clear() async {
    await _storage.delete(key: 'aesKey');

    _key = null;
  }
}
