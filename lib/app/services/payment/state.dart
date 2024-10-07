import 'package:dimipay_app_v2/app/services/payment/model.dart';

sealed class PaymentMethodsState {
  const PaymentMethodsState();
}

final class PaymentMethodsStateInitial extends PaymentMethodsState {
  const PaymentMethodsStateInitial();
}

final class PaymentMethodsStateLoading extends PaymentMethodsState {
  const PaymentMethodsStateLoading();
}

final class PaymentMethodsStateSuccess extends PaymentMethodsState {
  const PaymentMethodsStateSuccess({required this.value});
  final List<PaymentMethod> value;
}

final class PaymentMethodsStateFailed extends PaymentMethodsState {
  const PaymentMethodsStateFailed({required this.exception});
  final Exception exception;
}
