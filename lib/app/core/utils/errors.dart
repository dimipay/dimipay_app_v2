class OnboardingTokenException implements Exception {
  final String message;
  OnboardingTokenException(this.message);
}

class NoRefreshTokenException implements Exception {
  final String message;
  NoRefreshTokenException({this.message = ''});
}

class FaceSignException implements Exception {
  final String message;
  FaceSignException(this.message);
}

class IncorrectPinException implements Exception {
  final String message = '잘못된 핀을 입력했어요.';
  final int left;
  IncorrectPinException({required this.left});
}

class PinLockException implements Exception {
  final String message;
  PinLockException(this.message);
}

class NotDimigoMailException implements Exception {
  final String? message;
  NotDimigoMailException({this.message});
}

class SameNumberPinException implements Exception {
  final String message = '한가지 숫자로 핀을 설정할 수 없어요.';
}

class ContinuousPinException implements Exception {
  final String message = '연속되는 숫자로 핀을 설정할 수 없어요.';
}

class WrongCredentialsException implements Exception {
  final String message = '이메일 또는 비밀번호가 올바르지 않아요';
}

class NotPasswordUserException implements Exception {
  final String message = '비밀번호로 로그인할 수 없어요.';
}