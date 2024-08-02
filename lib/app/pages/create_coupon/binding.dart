import 'package:dimipay_app_v2/app/pages/create_coupon/controller.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class CreateCouponPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCouponPageController());
    Get.lazyPut(() => UserService());
  }
}
