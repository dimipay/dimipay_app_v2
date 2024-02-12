import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/services/bio_auth/service.dart';
import 'package:get/get.dart';

class PinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinPageController());
    Get.lazyPut(() => LocalAuthService());
  }
}
