import 'package:dimipay_app_v2/app/core/middleware/login.dart';
import 'package:dimipay_app_v2/app/core/middleware/onboarding.dart';
import 'package:dimipay_app_v2/app/pages/edit_card/binding.dart';
import 'package:dimipay_app_v2/app/pages/edit_card/page.dart';
import 'package:dimipay_app_v2/app/pages/face_sign/binding.dart';
import 'package:dimipay_app_v2/app/pages/face_sign/page.dart';
import 'package:dimipay_app_v2/app/pages/home/binding.dart';
import 'package:dimipay_app_v2/app/pages/home/page.dart';
import 'package:dimipay_app_v2/app/pages/info/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/page.dart';
import 'package:dimipay_app_v2/app/pages/login/binding.dart';
import 'package:dimipay_app_v2/app/pages/login/page.dart';
import 'package:dimipay_app_v2/app/pages/pin/binding.dart';
import 'package:dimipay_app_v2/app/pages/pin/page.dart';
import 'package:dimipay_app_v2/app/pages/payment/binding.dart';
import 'package:dimipay_app_v2/app/pages/payment/page.dart';
import 'package:dimipay_app_v2/app/pages/register_card/binding.dart';
import 'package:dimipay_app_v2/app/pages/register_card/register_card.dart';
import 'package:dimipay_app_v2/app/pages/test/page.dart';
import 'package:dimipay_app_v2/app/pages/user/binding.dart';
import 'package:dimipay_app_v2/app/pages/user/page.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.TEST, page: () => const TestPage()),
    GetPage(name: Routes.HOME, page: () => const HomePage(), binding: HomePageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.LOGIN, page: () => const LogInPage(), binding: LoginPageBinding()),
    GetPage(name: Routes.PIN, page: () => const PinPage(), binding: PinPageBinding(), middlewares: [
      LoginMiddleware(),
    ]),
    GetPage(name: Routes.USER, page: () => const UserPage(), binding: UserPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.INFO, page: () => const InfoPage(), binding: InfoPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.FACESIGN, page: () => const FaceSignPage(), binding: FaceSignBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.PAYMENT, page: () => const PaymentPage(), binding: PaymentPageBinding()),
    GetPage(name: Routes.REGISTER_CARD, page: () => const RegisterCardPage(), binding: RegisterCardPageBinding()),
    GetPage(name: Routes.EDIT_CARD, page: () => const EditCardPage(), binding: EditCardPageBinding())
  ];
}
