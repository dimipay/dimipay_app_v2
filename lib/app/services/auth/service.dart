import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/aes.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/bio_key.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/device_id.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/jwt.dart';
import 'package:dimipay_app_v2/app/services/auth/key_manager/rsa.dart';
import 'package:dimipay_app_v2/app/services/auth/repository.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:dimipay_app_v2/app/services/push/service.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

  final Rx<bool> _isOnboardingSessionReady = Rx(false);
  bool get _hasOnboardingSession =>
      _isOnboardingSessionReady.value && onboardingToken.accessToken != null;

  final RxString _authDiagnosticStage = 'idle'.obs;
  String get authDiagnosticStage => _authDiagnosticStage.value;
  bool get hasOnboardingAccessToken => onboardingToken.accessToken != null;
  bool get isOnboardingSessionReady => _isOnboardingSessionReady.value;

  final Rx<String?> _pin = Rx(null);
  String? get pin => _pin.value;

  String? _otp;
  String? get otp => _otp;

  /// google sign-in 과정이 완료되었을 경우 true
  bool get isGoogleLoginSuccess => _hasOnboardingSession;
  bool get isPasswordLoginSuccess => _hasOnboardingSession;

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => jwt.token.accessToken != null;

  AuthService({AuthRepository? repository})
      : repository = repository ?? AuthRepository();

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
    await _logLoginStage('before_rsa_generate');
    final KeyPair keyPair = await RsaManager.generateRSAKeyPair();
    await _logLoginStage('after_rsa_generate');

    await rsa.setKey(keyPair);
    await _logLoginStage('after_rsa_storage_write');

    await _logLoginStage('before_encryption_key_request');
    final String rawAesEncKey = await repository.getEncryptionKey(
        rsa.key!.publicKey, onboardingToken.accessToken!);
    await _logLoginStage('after_encryption_key_response');

    await aes.setKey(await RSA.decryptOAEPBytes(
        base64.decode(rawAesEncKey), '', Hash.SHA1, rsa.key!.privateKey));
    await _logLoginStage('after_aes_key_storage_write');
  }

  Future<String?> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;
    return googleAuth.idToken!;
  }

  Future<void> loginWithGoogle({bool selectAccount = true}) async {
    await _logLoginStage('google_start');
    _clearOnboardingSession();

    String? idToken = await _signInWithGoogle();
    if (idToken == null) {
      await _logLoginStage('google_cancelled_or_no_id_token');
      return;
    }

    try {
      await _logLoginStage('google_before_backend_login');
      final (jwt, isFirstVisitValue) =
          await repository.loginWithGoogle(idToken);
      _onboardingToken.value = jwt;
      _isFirstVisit.value = isFirstVisitValue;
      await _logLoginState('google_after_backend_login');

      await _getEncryptionKey();
      _isOnboardingSessionReady.value = true;
      await _logLoginState('google_ready_for_pin');
    } on NotDimigoMailException {
      await _logLoginStage('google_not_dimigo_mail');
      _clearOnboardingSession();
      throw NotDimigoMailException();
    } on Object catch (e, stackTrace) {
      await _recordLoginFailure('google_failed', e, stackTrace);
      _clearOnboardingSession();
      rethrow;
    } finally {
      unawaited(_clearGoogleSignInInfo());
    }
  }

  Future<void> loginWithPassword(
      {required String email, required String password}) async {
    await _logLoginStage('password_start');
    _clearOnboardingSession();

    try {
      await _logLoginStage('password_before_backend_login');
      final (jwt, isFirstVisitValue) =
          await repository.loginWithPassword(email: email, password: password);
      _onboardingToken.value = jwt;
      _isFirstVisit.value = isFirstVisitValue;
      await _logLoginState('password_after_backend_login');

      await _getEncryptionKey();
      _isOnboardingSessionReady.value = true;
      await _logLoginState('password_ready_for_pin');
    } on Object catch (e, stackTrace) {
      await _recordLoginFailure('password_failed', e, stackTrace);
      _clearOnboardingSession();
      rethrow;
    }
  }

  ///throws IncorrectPinException when pin wrong
  ///throws PinLockException when pin locked
  ///thows OnboardingTokenException when OnboardingToken is wrong
  Future<void> onBoardingAuth(String paymentPin) async {
    _pin.value = paymentPin;
    String newDeviceId = const Uuid().v4();

    String newBioKey = const Uuid().v4();
    JwtToken newJwt = await repository.onBoardingAuth(
        paymentPin, newDeviceId, newBioKey, onboardingToken.accessToken!);

    await jwt.setToken(newJwt);
    dev.log('logged in successfully!');
    dev.log(
        'accessToken expires at ${JwtDecoder.getExpirationDate(jwt.token.accessToken!)}');
    dev.log(
        'refreshToken expires at ${JwtDecoder.getExpirationDate(jwt.token.refreshToken!)}');

    await deviceId.setKey(newDeviceId);
    await bioKey.setKey(newBioKey);

    _pin.value = paymentPin;
    _clearOnboardingSession();
  }

  Future<void> _clearTokens() async {
    await jwt.clear();
    await aes.clear();
    await bioKey.clear();
    await deviceId.clear();
    await rsa.clear();
    await Get.find<PushService>().deleteToken();

    _pin.value = null;
    _clearOnboardingSession();
  }

  void invalidateAuthToken() {
    bioKey.invalidate();
    jwt.invalidate();
    _otp = null;
  }

  Future<void> _clearGoogleSignInInfo() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
    } on Exception catch (e) {
      dev.log('failed to clear google sign-in info', error: e);
    }
  }

  void _clearOnboardingSession() {
    _onboardingToken.value = JwtToken();
    _isFirstVisit.value = false;
    _isOnboardingSessionReady.value = false;
  }

  Future<void> _logLoginStage(String stage) async {
    _authDiagnosticStage.value = stage;
    dev.log(stage, name: 'AUTH_DIAG');
    await FirebaseCrashlytics.instance.setCustomKey('auth_diag_stage', stage);
    FirebaseCrashlytics.instance.log('auth_diag_stage=$stage');
  }

  Future<void> _logLoginState(String stage) async {
    await _logLoginStage(stage);
    await FirebaseCrashlytics.instance.setCustomKey(
      'auth_diag_has_onboarding_access_token',
      onboardingToken.accessToken != null,
    );
    await FirebaseCrashlytics.instance.setCustomKey(
      'auth_diag_is_first_visit',
      _isFirstVisit.value,
    );
    await FirebaseCrashlytics.instance.setCustomKey(
      'auth_diag_is_session_ready',
      _isOnboardingSessionReady.value,
    );
  }

  Future<void> _recordLoginFailure(
    String stage,
    Object error,
    StackTrace stackTrace,
  ) async {
    await _logLoginStage(stage);
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'auth_diagnostic_failure',
      fatal: false,
    );
  }

  Future<void> logout() async {
    await _clearTokens();
    await Get.find<HttpCacheService>().clear();
  }
}
