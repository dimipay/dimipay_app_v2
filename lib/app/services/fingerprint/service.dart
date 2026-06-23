import 'package:dimipay_app_v2/app/services/fingerprint/model.dart';
import 'package:dimipay_app_v2/app/services/fingerprint/repository.dart';
import 'package:dimipay_app_v2/app/services/fingerprint/state.dart';
import 'package:get/get.dart';

class FingerprintService extends GetxController {
  final FingerprintRepository repository;

  FingerprintService({FingerprintRepository? repository})
      : repository = repository ?? FingerprintRepository();

  final Rx<FingerprintsState> _fingerprintsState =
      Rx(const FingerprintsStateInitial());
  FingerprintsState get fingerprintsState => _fingerprintsState.value;

  Future<void> fetchFingerprints() async {
    try {
      _fingerprintsState.value = const FingerprintsStateLoading();
      _fingerprintsState.value =
          FingerprintsStateSuccess(value: await repository.getFingerprints());
    } on Exception catch (e) {
      _fingerprintsState.value = FingerprintsStateFailed(exception: e);
    }
  }

  Future<void> deleteFingerprint({required String name}) async {
    if (fingerprintsState is! FingerprintsStateSuccess) {
      return;
    }

    final List<Fingerprint> oldFingerprints = List<Fingerprint>.from(
        (fingerprintsState as FingerprintsStateSuccess).value);
    final List<Fingerprint> newFingerprints =
        List<Fingerprint>.from(oldFingerprints)
          ..removeWhere((e) => e.name == name);
    _fingerprintsState.value = FingerprintsStateSuccess(value: newFingerprints);

    try {
      await repository.deleteFingerprint(name: name);
    } on Exception {
      _fingerprintsState.value =
          FingerprintsStateSuccess(value: oldFingerprints);
      rethrow;
    }
  }
}
