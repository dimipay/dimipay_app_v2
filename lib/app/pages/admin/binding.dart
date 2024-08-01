import 'package:dimipay_app_v2/app/pages/admin/controller.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class AdminPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminPageController());
    Get.lazyPut(() => UserService());
  }
}
