import 'package:dimipay_app_v2/app/services/admin/cancel_transaction/repository.dart';
import 'package:get/get.dart';


class CancelTransactionService extends GetxController {
  final CancelTransactionRepository repository;

  CancelTransactionService({CancelTransactionRepository? repository})
      : repository = repository ?? CancelTransactionRepository();

  Future cancelTransaction({required String transactionId}) async {
    try {
      await repository.cancelTransaction(transactionId: transactionId);
    } catch (e) {
      rethrow;
    }
  }
}
