import 'package:dimipay_app_v2/app/services/transaction/model.dart';

sealed class TransactionsState {
  const TransactionsState();
}

final class TransactionsStateInitial extends TransactionsState {
  const TransactionsStateInitial();
}

final class TransactionsStateLoding extends TransactionsState {
  const TransactionsStateLoding();
}

final class TransactionsStateLoadingMore extends TransactionsState {
  const TransactionsStateLoadingMore({required this.transactions});
  final List<Transaction> transactions;
}

final class TransactionsStateSuccess extends TransactionsState {
  const TransactionsStateSuccess({required this.transactions});
  final List<Transaction> transactions;
}

final class TransactionsStateFailed extends TransactionsState {
  const TransactionsStateFailed({required this.exception});
  final Exception exception;
}
