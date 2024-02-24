import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/respository.dart';
import 'package:get/get.dart';

class TransactionService extends GetxController with StateMixin<List<Transaction>?> {
  final TransactionRepository repository;

  TransactionService({TransactionRepository? repository}) : repository = repository ?? TransactionRepository();

  final Rx<List<Transaction>?> _transactions = Rx(null);
  List<Transaction>? get transactions => _transactions.value;

  final Rx<DateTime?> _next = Rx(null);
  DateTime? get next => _next.value;

  bool get hasReachedEnd => next == null;

  int? get totalPrice => transactions?.fold(0, (a, b) => a! + b.totalPrice);

  Future<void> fetchTransactions({DateTime? offset}) async {
    try {
      change(transactions, status: RxStatus.loading());
      Map result = await repository.getTransactions(offset);
      _transactions.value = result["transactions"];

      if (result["next"] != null) {
        _next.value = DateTime.parse(result["next"]);
      } else {
        _next.value = null;
      }

      change(transactions, status: RxStatus.success());
    } catch (e) {
      change(transactions, status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> fetchMoreTransactions() async {
    if (next == null) {
      return;
    }

    try {
      Map result = await repository.getTransactions(next!);
      _transactions.value = [..._transactions.value!, ...result["transactions"]];

      if (result["next"] != null) {
        _next.value = DateTime.parse(result["next"]);
      } else {
        _next.value = null;
      }

      change(transactions, status: RxStatus.success());
    } catch (e) {
      rethrow;
    }
  }
}
