import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  Future onboardingAuth(String pin) async {
    await authService.onBoardingAuth(pin);
    Get.offNamed(Routes.HOME);
  }
}
