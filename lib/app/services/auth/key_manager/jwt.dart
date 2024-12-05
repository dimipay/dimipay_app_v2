import 'dart:async';
import 'dart:developer' as dev;

import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtToken {
  final String? accessToken;
  final String? refreshToken;

  JwtToken({this.accessToken, this.refreshToken});
}

class JwtManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final JwtRefresher _refresher = JwtRefresher();

  final Rx<JwtToken> _token = Rx(JwtToken());
  JwtToken get token => _token.value;

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

  Future<void> refresh() async {
    await _refresher.refresh(
      _token.value.refreshToken!,
      saveToken: setToken,
      onError: (e) async {
        await Get.find<AuthService>().logout();
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }

  void invalidate() {
    _token.value = JwtToken();
  }

  Future<void> clear() async {
    await _storage.delete(key: 'jwtRefreshToken');
    await _storage.delete(key: 'jwtAccessToken');

    _token.value = JwtToken();
  }
}

class JwtRefresher {
  Completer<JwtToken> _refreshTokenApiCompleter = Completer()..complete(JwtToken());
  final ApiProvider _api = Get.find<ApiProvider>();
  static final JwtRefresher _singleton = JwtRefresher._internal();

  factory JwtRefresher() {
    return _singleton;
  }

  JwtRefresher._internal();

  ///returns accessToken
  Future<JwtToken> _refreshTokenFromRemote(String refreshToken) async {
    String url = '/auth/refresh';

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $refreshToken',
    };
    DPHttpResponse response = await _api.get(DPHttpRequest(url, headers: headers));
    return JwtToken(accessToken: response.data['tokens']['accessToken'], refreshToken: response.data['tokens']['refreshToken']);
  }

  ///Throws exception and route to LoginPage if refresh faild
  Future<JwtToken> refresh(String refreshToken, {Function(JwtToken jwt)? saveToken, Function(Exception e)? onError}) async {
    // refreshTokenApi의 동시 다발적인 호출을 방지하기 위해 completer를 사용함. 동시 다발적으로 이 함수를 호출해도 api는 1번만 호출 됨.
    if (_refreshTokenApiCompleter.isCompleted == false) {
      return _refreshTokenApiCompleter.future;
    }

    //첫 호출(null)이거나 이미 완료된 호출(completed completer)일 경우 새 객체 할당
    _refreshTokenApiCompleter = Completer();
    try {
      JwtToken newJwt = await _refreshTokenFromRemote(refreshToken);

      dev.log('token refreshed!');
      dev.log('accessToken expires at ${JwtDecoder.getExpirationDate(newJwt.accessToken!)}');
      dev.log('refreshToken expires at ${JwtDecoder.getExpirationDate(newJwt.refreshToken!)}');
      await saveToken?.call(newJwt);
      _refreshTokenApiCompleter.complete(newJwt);
      return newJwt;
    } on Exception catch (e) {
      onError?.call(e);
      _refreshTokenApiCompleter.completeError(e);
      rethrow;
    }
  }
}
