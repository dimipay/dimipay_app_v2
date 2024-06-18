import 'package:dimipay_app_v2/app/pages/transaction/controller.dart';
import 'package:dimipay_app_v2/app/services/transaction/service.dart';
import 'package:get/get.dart';

class TransactionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionService>(() => TransactionService());
    Get.lazyPut<TransactionPageController>(() => TransactionPageController());
  }
}
