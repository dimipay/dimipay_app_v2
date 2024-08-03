import 'dart:developer';

import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/repository.dart';
import 'package:get/get.dart';

class CouponService extends GetxController with StateMixin<Coupon?> {
  final CouponRepository repository;

  CouponService({CouponRepository? repository})
      : repository = repository ?? CouponRepository();

  final Rx<Coupon?> _coupon = Rx(null);

  Coupon? get coupon => _coupon.value;

  final Rx<List<CouponType>?> _couponTypes = Rx(null);

  List<CouponType>? get couponTypes => _couponTypes.value;

  Future<Coupon> generateCoupon() async {
    Coupon generatedCoupon = await repository.generateCoupon();
    return generatedCoupon;
  }

  Future<void> fetchCouponTypes() async {
    try {
      Map data = await repository.getCouponTypes();
      _couponTypes.value = data["couponTypes"];
    } catch (e) {
      log(e.toString());
    }
  }
}
