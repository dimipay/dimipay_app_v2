import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/model.dart';
import 'package:dimipay_app_v2/app/services/auth/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final AuthRepository repository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Rx<JWTToken> _jwtToken = Rx(JWTToken());
  final Rx<JWTToken> _onboardingToken = Rx(JWTToken()); // /auth/login API에서 반환되는 AccessToken
  final Rx<bool> _isFirstVisit = Rx(false);
  final Rx<String?> _pin = Rx(null);
  String? _bioKey;
  Completer<void> _refreshTokenApiCompleter = Completer()..complete();

  AuthService({AuthRepository? repository}) : repository = repository ?? AuthRepository();

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => _jwtToken.value.accessToken != null;

  /// google sign-in 과정이 완료되었을 경우 true
  bool get isGoogleLoginSuccess => _onboardingToken.value.accessToken != null;
  String? get accessToken => _jwtToken.value.accessToken;
  String? get refreshToken => _jwtToken.value.refreshToken;
  String? get onboardingToken => _onboardingToken.value.accessToken;
  bool get isFirstVisit => _isFirstVisit.value;
  String? get bioKey => _bioKey;
  String? get pin => _pin.value;

  Future<String?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    return googleAuth.idToken!;
  }

  Future<AuthService> init() async {
    final String? accessToken = await _storage.read(key: 'accessToken');
    final String? refreshToken = await _storage.read(key: 'refreshToken');

    _jwtToken.value = JWTToken(accessToken: accessToken, refreshToken: refreshToken);

    return this;
  }

  Future<void> _setJWTToken(JWTToken newToken) async {
    await _storage.write(key: 'accessToken', value: newToken.accessToken);
    await _storage.write(key: 'refreshToken', value: newToken.refreshToken);
    _jwtToken.value = newToken;
  }

  Future<void> _setDeviceUid(String deviceUid) async {
    await _storage.write(key: 'deviceUid', value: deviceUid);
  }

  Future<void> _setBioKey(String bioKey) async {
    await _storage.write(key: 'bioKey', value: bioKey);
  }

  Future<void> loadBioKey() async {
    _bioKey = await _storage.read(key: 'bioKey');
  }

  Future<void> changePin(String originalPin, String newPin) async {
    await repository.changePin(originalPin, newPin);
    _pin.value = newPin;
  }

  Future<void> validatePin(String pin) async {
    await repository.checkPin(pin);
    _pin.value = pin;
  }

  Future<void> loginWithGoogle({bool selectAccount = true}) async {
    String? idToken = await _signInWithGoogle();
    if (idToken == null) {
      return;
    }

    dev.log('idToken: $idToken');
    Map loginResult = await repository.loginWithGoogle(idToken);

    _onboardingToken.value = JWTToken(accessToken: loginResult['tokens']['accessToken']);
    _isFirstVisit.value = loginResult['isFirstVisit'];
  }

  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<JWTToken> onBoardingAuth(String paymentPin) async {
    String deviceUid = const Uuid().v4();

    String? bioKey;
    if (!GetPlatform.isWeb) {
      bioKey = const Uuid().v4();
    }

    Map onboardingResult = await repository.onBoardingAuth(paymentPin, deviceUid, bioKey);

    await _setJWTToken(JWTToken(accessToken: onboardingResult['accessToken'], refreshToken: onboardingResult['refreshToken']));
    dev.log('logged in successfully!');
    dev.log('accessToken expires at ${JwtDecoder.getExpirationDate(accessToken!)}');
    dev.log('refreshToken expires at ${JwtDecoder.getExpirationDate(refreshToken!)}');
    await _setDeviceUid(deviceUid);
    if (!GetPlatform.isWeb) {
      await _setBioKey(bioKey!);
    }
    _pin.value = paymentPin;

    return _jwtToken.value;
  }

  ///Throws exception and route to loginpage if refresh faild
  Future<void> refreshAcessToken() async {
    // refreshTokenApi의 동시 다발적인 호출을 방지하기 위해 completer를 사용함. 동시 다발적으로 이 함수를 호출해도 api는 1번만 호출 됨.
    if (_refreshTokenApiCompleter.isCompleted == false) {
      return _refreshTokenApiCompleter.future;
    }

    //첫 호출(null)이거나 이미 완료된 호출(completed completer)일 경우 새 객체 할당
    _refreshTokenApiCompleter = Completer();
    try {
      if (refreshToken == null) {
        throw NoRefreshTokenException();
      }
      String newAccessToken = await repository.refreshAccessToken(refreshToken!);
      await _setJWTToken(JWTToken(accessToken: newAccessToken, refreshToken: refreshToken));
      _refreshTokenApiCompleter.complete();
    } catch (_) {
      await logout();
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
    await _storage.delete(key: 'bioKey');
    await _storage.delete(key: 'deviceUid');

    _jwtToken.value = JWTToken();
    _onboardingToken.value = JWTToken();
    _bioKey = null;
    _pin.value = null;
  }

  Future<void> logout() async {
    await _clearTokens();
    try {
      if (Platform.isAndroid) {
        await _googleSignIn.signOut();
      } else {
        await _googleSignIn.disconnect();
      }
    } catch (e) {
      await _googleSignIn.disconnect();
    }
  }
}
