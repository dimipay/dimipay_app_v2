import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/model.dart';

sealed class FingerprintPasscodeState {
  const FingerprintPasscodeState();
}

final class FingerprintPasscodeStateInitial extends FingerprintPasscodeState {
  const FingerprintPasscodeStateInitial();
}

final class FingerprintPasscodeStateLoading extends FingerprintPasscodeState {
  const FingerprintPasscodeStateLoading();
}

final class FingerprintPasscodeStateSuccess extends FingerprintPasscodeState {
  const FingerprintPasscodeStateSuccess({required this.value});
  final FingerprintPasscode value;
}

final class FingerprintPasscodeStateFailed extends FingerprintPasscodeState {
  const FingerprintPasscodeStateFailed({required this.exception});
  final Exception exception;
}
