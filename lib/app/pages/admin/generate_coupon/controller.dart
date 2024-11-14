import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:get/get.dart';

class GenerateCouponPageController extends GetxController {
  final CouponService couponService = Get.find<CouponService>();

  @override
  void onInit() {
    super.onInit();
    fetchCouponTypes();
  }

  Future<void> fetchCouponTypes() async {
    await couponService.fetchCouponTypes();
  }
}
