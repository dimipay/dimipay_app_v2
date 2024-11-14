import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/aes.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/bio_key.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/device_id.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/jwt.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/rsa.dart';
import 'package:dimipay_app_v2/app/services/auth/repository.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:dimipay_app_v2/app/services/push/service.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final AuthRepository repository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late final JwtManager jwt;
  late final AesManager aes;
  late final RsaManager rsa;
  late final DeviceIdManager deviceId;
  late final BioKeyManager bioKey;

  final Rx<bool> _isFirstVisit = Rx(false);
  bool get isFirstVisit => _isFirstVisit.value;

  final Rx<String?> _pin = Rx(null);
  String? get pin => _pin.value;

  /// google sign-in 과정이 완료되었을 경우 true
  bool get isGoogleLoginSuccess => jwt.onboardingToken.accessToken != null;
  bool get isPasswordLoginSuccess => jwt.onboardingToken.accessToken != null;

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => jwt.token.accessToken != null;

  Completer _refreshTokenApiCompleter = Completer()..complete();

  AuthService({AuthRepository? repository}) : repository = repository ?? AuthRepository();

  Future<AuthService> init() async {
    jwt = await JwtManager().init();
    aes = await AesManager().init();
    rsa = await RsaManager().init();
    deviceId = await DeviceIdManager().init();
    bioKey = BioKeyManager();

    return this;
  }

  Future<void> changePin(String newPin) async {
    await repository.changePin(newPin);
    _pin.value = newPin;
  }

  Future<void> registerPin(String pin) async {
    await repository.registerPin(pin, jwt.onboardingToken.accessToken!);
    _pin.value = pin;
  }

  Future<void> pinCheck(String pin) async {
    await repository.checkPin(pin);
    _pin.value = pin;
  }

  Future<void> _getEncryptionKey() async {
    rsa.setKey(await RsaManager.generateRSAKeyPair());
    final String rawAesEncKey = await repository.getEncryptionKey(rsa.key!.publicKey.replaceAll('\n', '\\r\\n'), jwt.onboardingToken.accessToken!);

    aes.setKey(await RSA.decryptOAEPBytes(base64.decode(rawAesEncKey), '', Hash.SHA1, rsa.key!.privateKey));
  }

  Future<String?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
    if (googleAccount == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    return googleAuth.idToken!;
  }

  Future<void> loginWithGoogle({bool selectAccount = true}) async {
    String? idToken = await _signInWithGoogle();
    if (idToken == null) {
      return;
    }

    Map loginResult = await repository.loginWithGoogle(idToken);
    jwt.setOnboardingToken(JwtToken(accessToken: loginResult['tokens']['accessToken']));
    _isFirstVisit.value = loginResult['isFirstVisit'];

    await _getEncryptionKey();
  }

  Future<void> loginWithPassword({required String email, required String password}) async {
    Map loginResult = await repository.loginWithPassword(email: email, password: password);
    jwt.setOnboardingToken(JwtToken(accessToken: loginResult['tokens']['accessToken']));
    _isFirstVisit.value = loginResult['isFirstVisit'];

    await _getEncryptionKey();
  }

  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<void> onBoardingAuth(String paymentPin) async {
    _pin.value = paymentPin;
    String newDeviceId = const Uuid().v4();

    String newBioKey = const Uuid().v4();
    Map onboardingResult = await repository.onBoardingAuth(paymentPin, newDeviceId, newBioKey, jwt.onboardingToken.accessToken!);

    await jwt.setToken(JwtToken(accessToken: onboardingResult['accessToken'], refreshToken: onboardingResult['refreshToken']));
    dev.log('logged in successfully!');
    dev.log('accessToken expires at ${JwtDecoder.getExpirationDate(jwt.token.accessToken!)}');
    dev.log('refreshToken expires at ${JwtDecoder.getExpirationDate(jwt.token.refreshToken!)}');

    await deviceId.setKey(newDeviceId);
    await bioKey.setKey(newBioKey);

    _pin.value = paymentPin;
  }

  ///Throws exception and route to LoginPage if refresh faild
  Future<void> refreshAcessToken() async {
    // refreshTokenApi의 동시 다발적인 호출을 방지하기 위해 completer를 사용함. 동시 다발적으로 이 함수를 호출해도 api는 1번만 호출 됨.
    if (_refreshTokenApiCompleter.isCompleted == false) {
      return _refreshTokenApiCompleter.future;
    }

    //첫 호출(null)이거나 이미 완료된 호출(completed completer)일 경우 새 객체 할당
    _refreshTokenApiCompleter = Completer();
    try {
      JwtToken newJwt = await repository.refreshAccessToken(jwt.token.refreshToken!);
      if (jwt.token.refreshToken == null) {
        throw NoRefreshTokenException();
      }
      dev.log('token refreshed!');
      dev.log('accessToken expires at ${JwtDecoder.getExpirationDate(newJwt.accessToken!)}');
      dev.log('refreshToken expires at ${JwtDecoder.getExpirationDate(newJwt.refreshToken!)}');
      await jwt.setToken(newJwt);
      _refreshTokenApiCompleter.complete();
    } catch (e) {
      await logout();
      Get.offAllNamed(Routes.LOGIN);
      _refreshTokenApiCompleter.completeError(e);
      rethrow;
    }
  }

  Future<void> _clearTokens() async {
    await jwt.clear();
    await aes.clear();
    await bioKey.clear();
    await deviceId.clear();
    await rsa.clear();
    await Get.find<PushService>().deleteToken();

    _pin.value = null;
  }

  Future<void> clearGoogleSignInInfo() async {
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

  Future<void> logout() async {
    await _clearTokens();
    await clearGoogleSignInInfo();
    await Get.find<HttpCacheService>().clear();
  }
}
