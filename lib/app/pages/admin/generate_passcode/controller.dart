import 'package:dimipay_app_v2/app/services/admin/kiosk/service.dart';
import 'package:get/get.dart';

class GeneratePasscodePageController extends GetxController {
  final KioskService kioskService = Get.find<KioskService>();

  @override
  void onInit() {
    super.onInit();
    fetchKiosks();
  }

  Future<void> fetchKiosks() async {
    await kioskService.fetchKiosks();
  }
}
