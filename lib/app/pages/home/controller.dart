import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  UserService userService = Get.find<UserService>();

  @override
  void onInit() {
    userService.fetchUser();
    super.onInit();
  }
}
