import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class InfoPageController extends GetxController {
  UserService userService = Get.find<UserService>();
  AuthService authService = Get.find<AuthService>();

  @override
  void onInit() {
    if (userService.user == null) {
      userService.fetchUser();
    }
    super.onInit();
  }

  void logout() async {
    await authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
