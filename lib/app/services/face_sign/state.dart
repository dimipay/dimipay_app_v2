sealed class FaceSignState {
  const FaceSignState();
}

final class FaceSignStateInitial extends FaceSignState {
  const FaceSignStateInitial();
}

final class FaceSignStateLoading extends FaceSignState {
  const FaceSignStateLoading();
}

final class FaceSignStateRegistering extends FaceSignState {
  const FaceSignStateRegistering();
}

final class FaceSignStatePatching extends FaceSignState {
  const FaceSignStatePatching();
}

final class FaceSignStateSuccess extends FaceSignState {
  const FaceSignStateSuccess({required this.isRegistered});
  final bool isRegistered;
}

final class FaceSignStateFailed extends FaceSignState {
  const FaceSignStateFailed({required this.exception});
  final Exception exception;
}
