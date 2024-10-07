import 'package:dimipay_app_v2/app/services/user/model.dart';

sealed class UserState {
  const UserState();
}

final class UserStateInitial extends UserState {
  const UserStateInitial();
}

final class UserStateLoading extends UserState {
  const UserStateLoading();
}

final class UserStateSuccess extends UserState {
  const UserStateSuccess({required this.value});
  final User value;
}

final class UserStateFailed extends UserState {
  const UserStateFailed({required this.exception});
  final Exception exception;
}
