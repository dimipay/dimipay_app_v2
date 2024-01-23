import 'dart:developer' as dev;

import 'package:dimipay_app_v2/app/services/transaction/model.dart';
import 'package:dimipay_app_v2/app/services/transaction/respository.dart';
import 'package:get/get.dart';

class TransactionService extends GetxController
    with StateMixin<List<Transaction>?> {
  final TransactionRepository repository;

  TransactionService({TransactionRepository? repository})
      : repository = repository ?? TransactionRepository();

  final Rx<List<Transaction>?> _transactions = Rx(null);
  List<Transaction>? get transactions => _transactions.value;

  Future fetchTransactions() async {
    dev.log("Fetching transactions");
    try {
      change(transactions, status: RxStatus.loading());
      _transactions.value = await repository.getTransactions();
      change(transactions, status: RxStatus.success());
    } catch (e) {
      change(transactions, status: RxStatus.error());
      rethrow;
    }
  }
}
