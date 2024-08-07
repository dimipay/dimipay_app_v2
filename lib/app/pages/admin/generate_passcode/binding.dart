import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/service.dart';
import 'package:get/get.dart';

class GeneratePasscodePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GeneratePasscodePageController());
    Get.lazyPut(() => KioskService());
  }
}
