import 'package:dimipay_app_v2/app/pages/admin/create_coupon/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:get/get.dart';

class CreateCouponPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCouponPageController());
    Get.lazyPut(() => CouponService());
  }
}
