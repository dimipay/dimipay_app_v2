import 'package:get/get.dart';

import 'package:dimipay_app_v2/app/pages/home/controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
