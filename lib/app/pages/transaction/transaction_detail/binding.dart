import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/controller.dart';
import 'package:get/get.dart';

class TransactionDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionDetailPageController());
  }
}
