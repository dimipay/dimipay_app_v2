import 'package:dimipay_app_v2/app/services/admin/kiosk/model.dart';

sealed class KiosksState {
  const KiosksState();
}

final class KiosksStateInitial extends KiosksState {
  const KiosksStateInitial();
}

final class KiosksStateLoading extends KiosksState {
  const KiosksStateLoading();
}

final class KiosksStateSuccess extends KiosksState {
  const KiosksStateSuccess({required this.value});
  final List<Kiosk> value;
}

final class KiosksStateFailed extends KiosksState {
  const KiosksStateFailed({required this.exception});
  final Exception exception;
}

sealed class PasscodeState {
  const PasscodeState();
}

final class PasscodeStateInitial extends PasscodeState {
  const PasscodeStateInitial();
}

final class PasscodeStateLoading extends PasscodeState {
  const PasscodeStateLoading();
}

final class PasscodeStateSuccess extends PasscodeState {
  const PasscodeStateSuccess({required this.value});
  final Passcode value;
}

final class PasscodeStateFailed extends PasscodeState {
  const PasscodeStateFailed({required this.exception});
  final Exception exception;
}
