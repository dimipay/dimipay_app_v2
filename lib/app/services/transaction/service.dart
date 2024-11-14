import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/respository.dart';
import 'package:dimipay_app_v2/app/services/transaction/state.dart';
import 'package:get/get.dart';

class TransactionService extends GetxController {
  final TransactionRepository repository;

  TransactionService({TransactionRepository? repository}) : repository = repository ?? TransactionRepository();

  final Rx<TransactionsState> _transactionsState = Rx(const TransactionsStateInitial());
  TransactionsState get transactionsState => _transactionsState.value;

  int _currentYear = DateTime.now().year;

  int _currentMonth = DateTime.now().month;

  final Rx<int> _currentMonthTotal = Rx(0);

  int get currentMonthTotal => _currentMonthTotal.value;

  final Rx<String?> _nextCursor = Rx(null);

  bool get hasReachedEnd => _nextCursor.value == null;

  Future<void> getTransactions({required int year, required int month}) async {
    try {
      _transactionsState.value = const TransactionsStateLoading();
      final result = await repository.getTransactions(year: year, month: month);
      _transactionsState.value = TransactionsStateSuccess(value: result.transactions);
      _nextCursor.value = result.nextCursor;
      _currentMonthTotal.value = result.monthTotal;

      _currentYear = year;
      _currentMonth = month;
    } on Exception catch (e) {
      _transactionsState.value = TransactionsStateFailed(exception: e);
      rethrow;
    }
  }

  Future<void> loadMoreTransactions() async {
    if (hasReachedEnd) {
      return;
    }
    if (_transactionsState.value is! TransactionsStateSuccess) {
      return;
    }
    _transactionsState.value = TransactionsStateLoadingMore(value: (_transactionsState.value as TransactionsStateSuccess).value);

    final result = await repository.getTransactions(year: _currentYear, month: _currentMonth, cursor: _nextCursor.value);
    List<Transaction> newTransactions = (_transactionsState.value as TransactionsStateLoadingMore).value + result.transactions;
    _transactionsState.value = TransactionsStateSuccess(value: newTransactions);

    _nextCursor.value = result.nextCursor;
  }

  Future<TransactionDetail> getTransactionDetail(String transactionId) async {
    return await repository.getTransactionDetail(transactionId);
  }

  @Deprecated('개발용임.')
  Future<TransactionDetail> createTransaction({
    required DateTime createdAt,
    required String status,
    required String transactionType,
    required String purchaseType,
    required int products,
    required PaymentMethod paymentMethod,
  }) async {
    return await repository.createTransaction(
      createdAt: createdAt,
      status: status,
      transactionType: transactionType,
      purchaseType: purchaseType,
      products: products,
      paymentMethod: paymentMethod,
    );
  }
}
