import 'package:dimipay_app_v2/app/services/admin/kiosk/service.dart';
import 'package:get/get.dart';

class PasscodePageController extends GetxController {
  final KioskService kioskService = Get.find<KioskService>();

  @override
  void onInit() {
    super.onInit();
    final String? kioskId = Get.arguments as String?;
    if (kioskId != null) {
      generatePasscode(id: kioskId);
    }
  }

  Future<void> generatePasscode({required String id}) async {
    await kioskService.generatePasscode(id: id);
  }

  @override
  void onClose() {
    kioskService.resetPasscode();
    super.onClose();
  }
}
