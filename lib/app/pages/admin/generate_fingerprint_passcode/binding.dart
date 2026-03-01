import 'package:dimipay_app_v2/app/pages/admin/generate_fingerprint_passcode/controller.dart';
import 'package:dimipay_app_v2/app/services/admin/fingerprint_kiosk/service.dart';
import 'package:get/get.dart';

class GenerateFingerprintPasscodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenerateFingerprintPasscodePageController());
    Get.lazyPut(() => FingerprintKioskService());
  }
}
