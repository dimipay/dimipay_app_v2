import 'package:dimipay_app_v2/app/pages/edit_card/controller.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:get/get.dart';

class EditCardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(() => PaymentService());
    Get.lazyPut<EditCardPageController>(
      () => EditCardPageController(),
    );
  }
}
