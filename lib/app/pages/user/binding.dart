import 'package:dimipay_app_v2/app/pages/user/controller.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class UserPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<UserPageController>(() => UserPageController());
  }
}
