import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService extends GetxController {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final Rx<List<BiometricType>> _availableBiometrics = Rx([]);

  bool get faceIdAvailable => _availableBiometrics.value.contains(BiometricType.face);
  bool get fingerprintAvailable => _availableBiometrics.value.contains(BiometricType.fingerprint);

  Future<bool> bioAuth() async {
    final res = await _localAuth.authenticate(
      localizedReason: '생체 인증을 사용하세요',
      options: const AuthenticationOptions(
        biometricOnly: true,
        sensitiveTransaction: false,
      ),
    );
    updateAvailableBiometrics();
    return res;
  }

  Future<void> updateAvailableBiometrics() async {
    _availableBiometrics.value = await _localAuth.getAvailableBiometrics();
  }
}
