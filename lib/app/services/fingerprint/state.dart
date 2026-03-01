import 'package:dimipay_app_v2/app/services/fingerprint/model.dart';

sealed class FingerprintsState {
  const FingerprintsState();
}

final class FingerprintsStateInitial extends FingerprintsState {
  const FingerprintsStateInitial();
}

final class FingerprintsStateLoading extends FingerprintsState {
  const FingerprintsStateLoading();
}

final class FingerprintsStateSuccess extends FingerprintsState {
  const FingerprintsStateSuccess({required this.value});
  final List<Fingerprint> value;
}

final class FingerprintsStateFailed extends FingerprintsState {
  const FingerprintsStateFailed({required this.exception});
  final Exception exception;
}
