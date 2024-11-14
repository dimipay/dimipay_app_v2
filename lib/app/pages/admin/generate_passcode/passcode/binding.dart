import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/passcode/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/kiosk/service.dart';
import 'package:get/get.dart';

class PasscodePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasscodePageController());
    Get.lazyPut(() => KioskService());
  }
}
