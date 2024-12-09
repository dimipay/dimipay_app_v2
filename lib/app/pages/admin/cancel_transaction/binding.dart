import 'package:get/get.dart';

import '../../../services/admin/transactions/service.dart';
import 'controller.dart';

class CancelTransactionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionsService());
    Get.lazyPut(() => CancelTransactionPageController());
  }
}
