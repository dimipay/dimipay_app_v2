import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final String? redirect = Get.arguments?['redirect'];

  Future onboardingAuth(String pin) async {
    await authService.onBoardingAuth(pin);
    final String nextRoute = redirect ?? Routes.HOME;
    Get.offNamed(nextRoute);
  }
}
