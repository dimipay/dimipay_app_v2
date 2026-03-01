import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/repository.dart';
import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/state.dart';
import 'package:get/get.dart';

class FingerprintKioskService extends GetxController {
  final FingerprintKioskRepository repository;

  FingerprintKioskService({FingerprintKioskRepository? repository})
      : repository = repository ?? FingerprintKioskRepository();

  static const int minLifeSeconds = 10;
  static const int maxLifeSeconds = 342000;

  final Rx<FingerprintPasscodeState> _passcodeState =
      Rx(const FingerprintPasscodeStateInitial());
  FingerprintPasscodeState get passcodeState => _passcodeState.value;

  Future<void> generatePasscode({required int life}) async {
    if (life < minLifeSeconds || life > maxLifeSeconds) {
      _passcodeState.value = FingerprintPasscodeStateFailed(
        exception: Exception(
            'RangeError: life should be between $minLifeSeconds and $maxLifeSeconds'),
      );
      return;
    }

    try {
      _passcodeState.value = const FingerprintPasscodeStateLoading();
      _passcodeState.value = FingerprintPasscodeStateSuccess(
        value: await repository.generatePasscode(life: life),
      );
    } on Exception catch (e) {
      _passcodeState.value = FingerprintPasscodeStateFailed(exception: e);
      rethrow;
    }
  }

  void resetPasscode() {
    _passcodeState.value = const FingerprintPasscodeStateInitial();
  }
}
