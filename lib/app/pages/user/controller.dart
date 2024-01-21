import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class UserPageController extends GetxController {
  final UserService userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    if (userService.user == null) {
      userService.fetchUser();
    }
  }
}
