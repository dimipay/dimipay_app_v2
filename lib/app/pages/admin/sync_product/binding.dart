import 'package:dimipay_app_v2/app/pages/admin/sync_product/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/products/service.dart';
import 'package:get/get.dart';

class SyncProductPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SyncProductPageController());
    Get.lazyPut(() => ProductsManageService());
  }
}
