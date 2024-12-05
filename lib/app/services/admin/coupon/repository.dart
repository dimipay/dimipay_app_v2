import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/admin/coupon/model.dart';
import 'package:get/get.dart';

class CouponRepository {
  final ApiProvider api;

  CouponRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Map> generateCoupon({required String id}) async {
    String url = '/admin/coupons';
    Map body = {'type': id};

    DPHttpResponse response = await api.post(DPHttpRequest(url, body: body), [JWT()]);

    Coupon coupon = Coupon.fromJson(response.data['coupon']);

    return {'coupon': coupon};
  }

  Future<Map> getCouponTypes() async {
    String url = '/admin/coupons/types';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT()]);

    List<CouponType> couponTypes = (response.data['types'] as List).map((e) => CouponType.fromJson(e)).toList();

    return {'couponTypes': couponTypes};
  }
}
