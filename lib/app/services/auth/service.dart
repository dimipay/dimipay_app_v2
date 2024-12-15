import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
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

  final JwtManager jwt = JwtManager();
  final AesManager aes = AesManager();
  final RsaManager rsa = RsaManager();
  final DeviceIdManager deviceId = DeviceIdManager();
  final BioKeyManager bioKey = BioKeyManager();

  final Rx<JwtToken> _onboardingToken = Rx(JwtToken());
  JwtToken get onboardingToken => _onboardingToken.value;

  final Rx<bool> _isFirstVisit = Rx(false);
  bool get isFirstVisit => _isFirstVisit.value;

  final Rx<String?> _pin = Rx(null);
  String? get pin => _pin.value;

  String? _otp;
  String? get otp => _otp;

  /// google sign-in 과정이 완료되었을 경우 true
  bool get isGoogleLoginSuccess => onboardingToken.accessToken != null;
  bool get isPasswordLoginSuccess => onboardingToken.accessToken != null;

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => jwt.token.accessToken != null;

  AuthService({AuthRepository? repository}) : repository = repository ?? AuthRepository();

  Future<AuthService> init() async {
    await jwt.init();
    await aes.init();
    await rsa.init();
    await deviceId.init();

    return this;
  }

  Future<void> changePin(String newPin) async {
    await repository.changePin(newPin);
    _pin.value = newPin;
  }

  Future<void> registerPin(String pin) async {
    await repository.registerPin(pin, onboardingToken.accessToken!);
    _pin.value = pin;
  }

  Future<void> pinCheck(String pin) async {
    _otp = await repository.checkPin(pin);
    _pin.value = pin;
  }

  Future<void> _getEncryptionKey() async {
    rsa.setKey(await RsaManager.generateRSAKeyPair());
    final String rawAesEncKey = await repository.getEncryptionKey(rsa.key!.publicKey, onboardingToken.accessToken!);

    aes.setKey(await RSA.decryptOAEPBytes(base64.decode(rawAesEncKey), '', Hash.SHA1, rsa.key!.privateKey));
  }

  Future<String?> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
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

    final (jwt, isFirstVisitValue) = await repository.loginWithGoogle(idToken);
    _onboardingToken.value = jwt;
    _isFirstVisit.value = isFirstVisitValue;
    _clearGoogleSignInInfo();

    await _getEncryptionKey();
  }

  Future<void> loginWithPassword({required String email, required String password}) async {
    final (jwt, isFirstVisitValue) = await repository.loginWithPassword(email: email, password: password);
    _onboardingToken.value = jwt;
    _isFirstVisit.value = isFirstVisitValue;

    await _getEncryptionKey();
  }

  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<void> onBoardingAuth(String paymentPin) async {
    _pin.value = paymentPin;
    String newDeviceId = const Uuid().v4();

    String newBioKey = const Uuid().v4();
    JwtToken newJwt = await repository.onBoardingAuth(paymentPin, newDeviceId, newBioKey, onboardingToken.accessToken!);

    await jwt.setToken(newJwt);
    dev.log('logged in successfully!');
    dev.log('accessToken expires at ${JwtDecoder.getExpirationDate(jwt.token.accessToken!)}');
    dev.log('refreshToken expires at ${JwtDecoder.getExpirationDate(jwt.token.refreshToken!)}');

    await deviceId.setKey(newDeviceId);
    await bioKey.setKey(newBioKey);

    _pin.value = paymentPin;
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

  void invalidateAuthToken() {
    bioKey.invalidate();
    jwt.invalidate();
    _otp = null;
  }

  Future<void> _clearGoogleSignInInfo() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (Platform.isAndroid) {
        await googleSignIn.signOut();
      } else {
        await googleSignIn.disconnect();
      }
    } on Exception {
      await googleSignIn.disconnect();
    }
  }

  Future<void> logout() async {
    await _clearTokens();
    await Get.find<HttpCacheService>().clear();
  }
}
