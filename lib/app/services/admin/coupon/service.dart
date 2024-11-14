import 'dart:developer';
import 'package:dimipay_app_v2/app/services/admin/coupon/repository.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/state.dart';
import 'package:get/get.dart';

class CouponService extends GetxController {
  final CouponRepository repository;

  CouponService({CouponRepository? repository}) : repository = repository ?? CouponRepository();

  final Rx<CouponState> _couponState = Rx(const CouponStateInitial());
  CouponState get couponState => _couponState.value;

  final Rx<CouponTypesState> _couponTypesState = Rx(const CouponTypesStateInitial());
  CouponTypesState get couponTypesState => _couponTypesState.value;

  Future<void> generateCoupon({required String id}) async {
    try {
      _couponState.value = const CouponStateInitial();
      Map data = await repository.generateCoupon(id: id);
      _couponState.value = CouponStateSuccess(value: data["coupon"]);
    } on Exception catch (e) {
      _couponState.value = CouponStateFailed(exception: e);
      log(e.toString());
    }
  }

  Future<void> fetchCouponTypes() async {
    try {
      _couponTypesState.value = const CouponTypesStateInitial();
      Map data = await repository.getCouponTypes();
      _couponTypesState.value = CouponTypesStateSuccess(value: data["couponTypes"]);
    } on Exception catch (e) {
      _couponTypesState.value = CouponTypesStateFailed(exception: e);
      log(e.toString());
    }
  }

  void resetCoupon() {
    _couponState.value = const CouponStateInitial();
  }
}
