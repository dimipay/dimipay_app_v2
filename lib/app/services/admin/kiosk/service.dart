import 'dart:developer';

import 'package:dimipay_app_v2/app/services/admin/kiosk/model.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/repository.dart';
import 'package:get/get.dart';

class KioskService extends GetxController with StateMixin<Passcode?> {
  final KioskRepository repository;

  KioskService({KioskRepository? repository})
      : repository = repository ?? KioskRepository();

  final Rx<Passcode?> _passcode = Rx(null);

  Passcode? get kioskPasscode => _passcode.value;

  final Rx<List<Kiosk>?> _kiosks = Rx(null);

  List<Kiosk>? get kiosks => _kiosks.value;

  Future generatePasscode({required String id}) async {
    try {
      _passcode.value = await repository.generatePasscode(id: id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchKiosks() async {
    try {
      Map data = await repository.getKiosks();
      _kiosks.value = data["kiosks"];
    } catch (e) {
      log(e.toString());
    }
  }

  void resetPasscode() {
    _passcode.value = null;
  }
}
