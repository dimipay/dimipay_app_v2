import 'package:dimipay_app_v2/app/pages/admin/reset_pin/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/user/service.dart';
import 'package:get/get.dart';

class ResetPinPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPinPageController());
    Get.lazyPut(() => UserManageService());
  }
}
