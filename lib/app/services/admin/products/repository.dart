import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductsManageRepository {
  final ApiProvider api;

  ProductsManageRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<void> syncProduct({required String barcode}) async {
    String url = '/admin/products/sync/$barcode';

    try {
      await api.post(DPHttpRequest(url), [JWT()]);
      return;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_PRODUCT_NOT_FOUND') {
        throw ProductNotFound(message: e.response?.data['message']);
      }
      if (e.response?.data['code'] == 'ERR_NO_SELLING_PRICE') {
        throw NoSellingPrice(message: e.response?.data['message']);
      }
      rethrow;
    }
  }
}
