import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:get/get.dart';

class CouponRepository {
  final ApiProvider api;

  CouponRepository({ApiProvider? api})
      : api = api ?? Get.find<SecureApiProvider>();

  Future<Coupon> generateCoupon() async {
    String url = '/admin/coupons';
    DPHttpResponse response = await api.get(url);
    return Coupon.fromJson(response.data);
  }

  Future<Map> getCouponTypes() async {
    String url = '/admin/coupons/types';
    DPHttpResponse response = await api.get(url);

    List<CouponType> couponTypes = (response.data["types"] as List)
        .map((e) => CouponType.fromJson(e))
        .toList();

    return {"couponTypes": couponTypes};
  }
}
