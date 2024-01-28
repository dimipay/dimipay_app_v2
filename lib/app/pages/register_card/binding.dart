import 'package:dimipay_app_v2/app/pages/register_card/controller.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class RegisterCardPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentService());
    Get.lazyPut(() => RegisterCardPageController());
    Get.lazyPut(() => UserService());
  }
}
