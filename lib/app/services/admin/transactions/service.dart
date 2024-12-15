import 'package:dimipay_app_v2/app/services/admin/transactions/repository.dart';
import 'package:get/get.dart';


class TransactionsService extends GetxController {
  final TransactionsRepository repository;

  TransactionsService({TransactionsRepository? repository})
      : repository = repository ?? TransactionsRepository();

  Future cancelTransaction({required String transactionId, required String reason}) async {
    try {
      await repository.cancelTransaction(transactionId: transactionId, reason: reason);
    } catch (e) {
      rethrow;
    }
  }
}
