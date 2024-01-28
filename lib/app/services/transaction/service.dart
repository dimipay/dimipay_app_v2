import 'dart:developer' as dev;

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

  Rx<bool> hasReachedEnd = Rx(false);

  Future<void> fetchTransactions({DateTime? offset}) async {
    dev.log("Fetching transactions");
    try {
      change(transactions, status: RxStatus.loading());
      Map result = await repository.getTransactions(offset);
      _transactions.value = result["transactions"];

      if (result["next"] != null) {
        _next.value = DateTime.parse(result["next"]);
      } else {
        _next.value = null;
        hasReachedEnd.value = true;
      }

      change(transactions, status: RxStatus.success());
    } catch (e) {
      change(transactions, status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> fetchMoreTransactions() async {
    if (next == null) {
      dev.log("No more transactions to fetch");
      hasReachedEnd.value = true;
      return;
    }

    dev.log("Fetching more transactions");
    dev.log("Next: $next");

    try {
      Map result = await repository.getTransactions(next!);
      _transactions.value = [..._transactions.value!, ...result["transactions"]];

      if (result["next"] != null) {
        _next.value = DateTime.parse(result["next"]);
      } else {
        _next.value = null;
        hasReachedEnd.value = true;
      }

      dev.log("Transactions Length : ${_transactions.value!.length}");
      change(transactions, status: RxStatus.success());
    } catch (e) {
      rethrow;
    }
  }
}
