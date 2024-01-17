import 'package:dimipay_app_v2/app/pages/login/controller.dart';
import 'package:get/get.dart';

class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }
}
