import 'package:dimipay_app_v2/app/services/admin/products/repository.dart';
import 'package:get/get.dart';

class ProductsManageService extends GetxController {
  final ProductsManageRepository repository;

  ProductsManageService({ProductsManageRepository? repository})
      : repository = repository ?? ProductsManageRepository();

  Future syncProduct({required String barcode}) async {
    try {
      await repository.syncProduct(barcode: barcode);
    } catch (e) {
      rethrow;
    }
  }
}
