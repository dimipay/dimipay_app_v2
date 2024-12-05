import 'package:dimipay_app_v2/app/pages/admin/cancel_transaction/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/cancel_transaction/service.dart';
import 'package:get/get.dart';

class CancelTransactionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CancelTransactionService());
    Get.lazyPut(() => CancelTransactionPageController());
  }
}
