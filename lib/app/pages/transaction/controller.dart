import 'package:dimipay_app_v2/app/services/transaction/service.dart';
import 'package:get/get.dart';

class TransactionPageController extends GetxController {
  final TransactionService transactionService = Get.find<TransactionService>();

  @override
  void onInit() async {
    super.onInit();
    if (transactionService.transactions == null) {
      transactionService.fetchTransactions();
    }
  }
}
