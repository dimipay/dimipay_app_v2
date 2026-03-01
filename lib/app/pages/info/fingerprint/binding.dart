import 'package:dimipay_app_v2/app/pages/info/fingerprint/controller.dart';
import 'package:dimipay_app_v2/app/services/fingerprint/service.dart';
import 'package:get/get.dart';

class FingerprintManagePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FingerprintManagePageController());
    Get.lazyPut(() => FingerprintService());
  }
}
