import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceIdManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _deviceId;
  String? get deviceId => _deviceId;

  Future<DeviceIdManager> init() async {
    _deviceId = await _storage.read(key: 'deviceId');
    return this;
  }

  Future<void> setKey(String newDeviceId) async {
    await _storage.write(key: 'deviceId', value: newDeviceId);
    _deviceId = newDeviceId;
  }

  Future<void> clear() async {
    await _storage.delete(key: 'deviceId');

    _deviceId = null;
  }
}
