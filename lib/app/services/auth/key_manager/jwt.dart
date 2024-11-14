import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class JwtToken {
  final String? accessToken;
  final String? refreshToken;

  JwtToken({this.accessToken, this.refreshToken});
}

class JwtManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final Rx<JwtToken> _token = Rx(JwtToken());
  JwtToken get token => _token.value;
  final Rx<JwtToken> _onboardingToken = Rx(JwtToken()); // /auth/login API에서 반환되는 AccessToken
  JwtToken get onboardingToken => _onboardingToken.value;

  Future<JwtManager> init() async {
    final String? accessToken = await _storage.read(key: 'jwtAccessToken');
    final String? refreshToken = await _storage.read(key: 'jwtRefreshToken');
    _token.value = JwtToken(accessToken: accessToken, refreshToken: refreshToken);
    return this;
  }

  Future<void> setToken(JwtToken newToken) async {
    await _storage.write(key: 'jwtAccessToken', value: newToken.accessToken);
    await _storage.write(key: 'jwtRefreshToken', value: newToken.refreshToken);
    _token.value = newToken;
  }

  void setOnboardingToken(JwtToken newToken) {
    _onboardingToken.value = newToken;
  }

  Future<void> clear() async {
    await _storage.delete(key: 'jwtRefreshToken');
    await _storage.delete(key: 'jwtAccessToken');

    _token.value = JwtToken();
    _onboardingToken.value = JwtToken();
  }
}
