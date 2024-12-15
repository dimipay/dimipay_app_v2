import 'dart:developer';
import 'package:dimipay_app_v2/app/services/admin/kiosk/repository.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/state.dart';
import 'package:get/get.dart';

class KioskService extends GetxController {
  final KioskRepository repository;

  KioskService({KioskRepository? repository}) : repository = repository ?? KioskRepository();

  final Rx<PasscodeState> _passCodeState = Rx(const PasscodeStateInitial());

  PasscodeState get passCodeState => _passCodeState.value;

  final Rx<KiosksState> _kiosksState = Rx(const KiosksStateInitial());

  KiosksState get kiosksState => _kiosksState.value;

  Future generatePasscode({required String id}) async {
    try {
      _passCodeState.value = const PasscodeStateLoading();
      _passCodeState.value = PasscodeStateSuccess(value: await repository.generatePasscode(id: id));
    } on Exception catch (e) {
      _passCodeState.value = PasscodeStateFailed(exception: e);
      rethrow;
    }
  }

  Future<void> fetchKiosks() async {
    try {
      _kiosksState.value = const KiosksStateInitial();
      Map data = await repository.getKiosks();
      _kiosksState.value = KiosksStateSuccess(value: data['kiosks']);
    } on Exception catch (e) {
      _kiosksState.value = KiosksStateFailed(exception: e);
      log(e.toString());
    }
  }

  void resetPasscode() {
    _passCodeState.value = const PasscodeStateInitial();
  }
}
