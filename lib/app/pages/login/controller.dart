import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  Future loginWithGoogle() async {
    await authService.loginWithGoogle();
    if (authService.isGoogleLoginSuccess) {
      Get.offNamed(Routes.ONBOARDINGPIN);
    }
  }

  Future clearTokens() async {
    await authService.logout();
  }
}
