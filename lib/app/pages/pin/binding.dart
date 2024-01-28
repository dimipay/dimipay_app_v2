import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:get/get.dart';

class PinPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinPageController());
  }
}
