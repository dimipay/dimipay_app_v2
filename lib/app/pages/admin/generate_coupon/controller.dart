import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class GenerateCouponPageController extends GetxController {
  final CouponService couponService = Get.find<CouponService>();
  final UserService userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    fetchCouponTypes();
  }

  @override
  Future<void> onReady() async {
    await Future.wait([
      userService.fetchUser(),
    ]);
  }

  Future<void> fetchCouponTypes() async {
    await couponService.fetchCouponTypes();
  }
}
