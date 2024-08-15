import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/respository.dart';
import 'package:get/get.dart';

class TransactionService extends GetxController with StateMixin<List<Transaction>?> {
  final TransactionRepository repository;

  TransactionService({TransactionRepository? repository}) : repository = repository ?? TransactionRepository();

  final Rx<List<Transaction>?> _transactions = Rx(null);
  List<Transaction>? get transactions => _transactions.value;

  int _currentYear = DateTime.now().year;

  int _currentMonth = DateTime.now().month;

  final Rx<int> _currentMonthTotal = Rx(0);

  int get currentMonthTotal => _currentMonthTotal.value;

  final Rx<String?> _nextCursor = Rx(null);

  bool get hasReachedEnd => _nextCursor.value == null;

  Future<void> getTransactions({required int year, required int month}) async {
    try {
      change(transactions, status: RxStatus.loading());
      Map result = await repository.getTransactions(year: year, month: month);
      _transactions.value = result["transactions"];
      _nextCursor.value = result['nextCursor'];
      _currentMonthTotal.value = result['monthTotal'];

      _currentYear = year;
      _currentMonth = month;

      change(transactions, status: RxStatus.success());
    } catch (e) {
      change(transactions, status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> loadMoreTransactions() async {
    if (hasReachedEnd) {
      return;
    }
    Map result = await repository.getTransactions(year: _currentYear, month: _currentMonth, cursor: _nextCursor.value);
    _transactions.value!.addAll(result["transactions"]);
    _nextCursor.value = result['nextCursor'];
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
