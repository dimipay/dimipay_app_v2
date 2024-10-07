import 'package:dimipay_app_v2/app/services/transaction/model.dart';

sealed class TransactionsState {
  const TransactionsState();
}

final class TransactionsStateInitial extends TransactionsState {
  const TransactionsStateInitial();
}

final class TransactionsStateLoading extends TransactionsState {
  const TransactionsStateLoading();
}

final class TransactionsStateLoadingMore extends TransactionsState {
  const TransactionsStateLoadingMore({required this.value});
  final List<Transaction> value;
}

final class TransactionsStateSuccess extends TransactionsState {
  const TransactionsStateSuccess({required this.value});
  final List<Transaction> value;
}

final class TransactionsStateFailed extends TransactionsState {
  const TransactionsStateFailed({required this.exception});
  final Exception exception;
}
