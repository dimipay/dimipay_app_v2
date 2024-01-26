import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

import 'package:dimipay_app_v2/app/pages/info/controller.dart';

class InfoPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfoPageController());
    Get.lazyPut(() => UserService());
  }
}
