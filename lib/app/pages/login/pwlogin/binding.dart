import 'package:dimipay_app_v2/app/pages/login/pwlogin/controller.dart';
import 'package:get/get.dart';

class PWLoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PWLoginPageController>(() => PWLoginPageController());
  }
}
