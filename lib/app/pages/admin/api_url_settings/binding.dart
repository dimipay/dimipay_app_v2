import 'package:dimipay_app_v2/app/pages/admin/api_url_settings/controller.dart';
import 'package:get/get.dart';

class ApiUrlSettingsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiUrlSettingsPageController());
  }
}