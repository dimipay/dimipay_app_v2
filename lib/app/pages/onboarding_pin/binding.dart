import 'package:dimipay_app_v2/app/pages/onboarding_pin/controller.dart';
import 'package:get/get.dart';

class OnboardingPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingPageController());
  }
}
