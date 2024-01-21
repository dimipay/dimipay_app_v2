class OnboardingTokenException implements Exception {
  final String message;
  OnboardingTokenException(this.message);
}

class NoRefreshTokenException implements Exception {
  final String message;
  NoRefreshTokenException({this.message = ''});
}

class FaceSginException implements Exception {
  final String message;
  FaceSginException(this.message);
}

class IncorrectPinException implements Exception {
  final String message;
  final int left;
  IncorrectPinException(this.message, this.left);
}

class PinLockException implements Exception {
  final String message;
  PinLockException(this.message);
}

class NotDimigoMailExceptoin implements Exception {
  final String? message;
  NotDimigoMailExceptoin({this.message});
}
