import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiUrlManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _apiUrl;
  String? get apiUrl => _apiUrl;

  Future<ApiUrlManager> init() async {
    _apiUrl = await _storage.read(key: 'apiUrl');
    return this;
  }

  Future<void> setUrl(String newUrl) async {
    await _storage.write(key: 'apiUrl', value: newUrl);
    _apiUrl = newUrl;
  }

  Future<void> clear() async {
    await _storage.delete(key: 'apiUrl');
    _apiUrl = null;
  }
}