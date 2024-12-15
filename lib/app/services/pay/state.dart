sealed class PaymentTokenState {
  const PaymentTokenState();
}

final class PaymentTokenInitial extends PaymentTokenState {
  const PaymentTokenInitial();
}

final class PaymentTokenLoading extends PaymentTokenState {
  const PaymentTokenLoading();
}

final class PaymentTokenSuccess extends PaymentTokenState {
  const PaymentTokenSuccess({
    required this.value,
    required this.expireAt,
    required this.lifetime,
  });
  final String value;
  final DateTime expireAt;
  final Duration lifetime;
}

final class PaymentTokenFailed extends PaymentTokenState {
  const PaymentTokenFailed({required this.exception});
  final Exception exception;
}
