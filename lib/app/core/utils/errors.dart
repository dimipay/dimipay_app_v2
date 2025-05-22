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
  final String? message;

  WrongCredentialsException({this.message});
}

class NotPasswordUserException implements Exception {
  final String? message;

  NotPasswordUserException({this.message});
}

class ProductNotFound implements Exception {
  final String? message;

  ProductNotFound({this.message});
}

class NoSellingPrice implements Exception {
  final String? message;

  NoSellingPrice({this.message});
}

class TransactionAlreadyCanceled implements Exception {
  final String? message;

  TransactionAlreadyCanceled({this.message});
}

class TransactionNotConfirmed implements Exception {
  final String? message;

  TransactionNotConfirmed({this.message});
}

class UnableToCancelTransaction implements Exception {
  final String? message;

  UnableToCancelTransaction({this.message});
}

class TransactionNotFound implements Exception {
  final String? message;

  TransactionNotFound({this.message});
}

class TransactionCancelFailed implements Exception {
  final String? message;

  TransactionCancelFailed({this.message});
}