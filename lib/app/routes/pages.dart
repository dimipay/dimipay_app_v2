import 'package:dimipay_app_v2/app/pages/face_sign/binding.dart';
import 'package:dimipay_app_v2/app/pages/face_sign/page.dart';
import 'package:dimipay_app_v2/app/pages/home/page.dart';
import 'package:dimipay_app_v2/app/pages/login/binding.dart';
import 'package:dimipay_app_v2/app/pages/login/page.dart';
import 'package:dimipay_app_v2/app/pages/onboarding_pin/binding.dart';
import 'package:dimipay_app_v2/app/pages/onboarding_pin/page.dart';
import 'package:dimipay_app_v2/app/pages/test/page.dart';
import 'package:dimipay_app_v2/app/pages/user/binding.dart';
import 'package:dimipay_app_v2/app/pages/user/page.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.TEST, page: () => const TestPage()),
    GetPage(name: Routes.HOME, page: () => const HomePage()),
    GetPage(name: Routes.LOGIN, page: () => const LogInPage(), binding: LoginPageBinding()),
    GetPage(name: Routes.ONBOARDINGPIN, page: () => const OnboardingPinPage(), binding: OnboardingPageBinding()),
    GetPage(name: Routes.USER, page: () => const UserPage(), binding: UserPageBinding()),
    GetPage(name: Routes.FACESIGN, page: () => const FaceSignPage(), binding: FaceSignBinding()),
  ];
}
