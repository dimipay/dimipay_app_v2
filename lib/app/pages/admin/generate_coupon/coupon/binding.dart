import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:get/get.dart';

class CouponPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CouponPageController());
    Get.lazyPut(() => CouponService());
  }
}
