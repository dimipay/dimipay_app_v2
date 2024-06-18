import 'package:dimipay_app_v2/app/pages/version/controller.dart';
import 'package:get/get.dart';

class VersionPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VersionPageController());
  }
}
