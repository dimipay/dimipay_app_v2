import 'package:dimipay_app_v2/app/pages/register_card/controller.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:get/get.dart';

class RegisterCardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(() => PaymentService());
    Get.lazyPut<RegisterCardPageController>(() => RegisterCardPageController());
  }
}
