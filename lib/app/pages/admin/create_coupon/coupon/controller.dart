import 'package:dimipay_app_v2/app/services/admin/coupon/service.dart';
import 'package:get/get.dart';

class CouponPageController extends GetxController {
  final CouponService couponService = Get.find<CouponService>();

  @override
  void onInit() {
    super.onInit();
    final String? couponTypeId = Get.arguments as String?;
    if (couponTypeId != null) {
      generateCoupon(id: couponTypeId);
    }
  }

  Future<void> generateCoupon({required String id}) async {
    await couponService.generateCoupon(id: id);
  }

  @override
  void onClose() {
    couponService.resetCoupon();
    super.onClose();
  }
}
