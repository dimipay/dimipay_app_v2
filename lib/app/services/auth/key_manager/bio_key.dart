import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BioKeyManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _bioKey;
  String? get key => _bioKey;

  Future<void> loadBioKey() async {
    _bioKey = await _storage.read(key: 'bioKey');
  }

  Future<void> setKey(String newBioKey) async {
    await _storage.write(key: 'bioKey', value: newBioKey);
    _bioKey = newBioKey;
  }

  Future<void> clear() async {
    await _storage.delete(key: 'bioKey');
    _bioKey = null;
  }
}
