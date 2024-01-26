import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class InfoPageController extends GetxController {
  UserService userService = Get.find<UserService>();

  @override
  void onInit() {
    if (userService.user == null) {
      userService.fetchUser();
    }
    super.onInit();
  }
}
