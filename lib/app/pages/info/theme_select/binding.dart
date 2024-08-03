import 'package:dimipay_app_v2/app/pages/info/theme_select/controller.dart';
import 'package:get/get.dart';

class ThemeSelectPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeSelectPageController());
  }
}
