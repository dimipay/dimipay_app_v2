import 'package:dimipay_app_v2/app/core/middleware/admin.dart';
import 'package:dimipay_app_v2/app/core/middleware/login.dart';
import 'package:dimipay_app_v2/app/core/middleware/onboarding.dart';
import 'package:dimipay_app_v2/app/pages/admin/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/passcode/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/passcode/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/page.dart';
import 'package:dimipay_app_v2/app/pages/home/binding.dart';
import 'package:dimipay_app_v2/app/pages/home/page.dart';
import 'package:dimipay_app_v2/app/pages/info/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/face_sign/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/face_sign/page.dart';
import 'package:dimipay_app_v2/app/pages/info/page.dart';
import 'package:dimipay_app_v2/app/pages/info/theme_select/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/theme_select/page.dart';
import 'package:dimipay_app_v2/app/pages/info/version/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/version/page.dart';
import 'package:dimipay_app_v2/app/pages/info/version/privacy_policy/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/version/privacy_policy/page.dart';
import 'package:dimipay_app_v2/app/pages/info/version/terms_of_service/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/version/terms_of_service/page.dart';
import 'package:dimipay_app_v2/app/pages/login/binding.dart';
import 'package:dimipay_app_v2/app/pages/login/page.dart';
import 'package:dimipay_app_v2/app/pages/manual/page.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/binding.dart';
import 'package:dimipay_app_v2/app/pages/onboarding/page.dart';
import 'package:dimipay_app_v2/app/pages/payment/binding.dart';
import 'package:dimipay_app_v2/app/pages/payment/edit_card/binding.dart';
import 'package:dimipay_app_v2/app/pages/payment/edit_card/page.dart';
import 'package:dimipay_app_v2/app/pages/payment/page.dart';
import 'package:dimipay_app_v2/app/pages/payment/register_card/binding.dart';
import 'package:dimipay_app_v2/app/pages/payment/register_card/page.dart';
import 'package:dimipay_app_v2/app/pages/pin/binding.dart';
import 'package:dimipay_app_v2/app/pages/pin/page.dart';
import 'package:dimipay_app_v2/app/pages/test/page.dart';
import 'package:dimipay_app_v2/app/pages/transaction/binding.dart';
import 'package:dimipay_app_v2/app/pages/transaction/page.dart';
import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/binding.dart';
import 'package:dimipay_app_v2/app/pages/transaction/transaction_detail/page.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.TEST, page: () => const TestPage()),
    GetPage(name: Routes.TRANSACTION, page: () => const TransactionPage(), binding: TransactionPageBinding()),
    GetPage(name: Routes.HOME, page: () => const HomePage(), binding: HomePageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.LOGIN, page: () => const LogInPage(), binding: LoginPageBinding()),
    GetPage(
        name: Routes.ONBOARDING,
        page: () => const OnboardingPage(),
        middlewares: [
          LoginMiddleware(),
        ],
        binding: OnboardingPageBinding()),
    GetPage(name: Routes.PIN, page: () => const PinPage(), binding: PinPageBinding(), middlewares: [
      LoginMiddleware(),
    ]),
    GetPage(name: Routes.INFO, page: () => const InfoPage(), binding: InfoPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.FACESIGN, page: () => const FaceSignPage(), binding: FaceSignBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.PAYMENT, page: () => const PaymentPage(), binding: PaymentPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.REGISTER_CARD, page: () => const RegisterCardPage(), binding: RegisterCardPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.EDIT_CARD, page: () => const EditCardPage(), binding: EditCardPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.TRANSACTION_DETAIL, page: () => const TransactionDetailPage(), binding: TransactionDetailPageBinding(), middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ]),
    GetPage(name: Routes.THEME_SELECT, page: () => const ThemeSelectPage(), binding: ThemeSelectPageBinding()),
    GetPage(name: Routes.VERSION, page: () => const VersionPage(), binding: VersionPageBinding()),
    GetPage(
      name: Routes.LICENSE,
      page: () => LicensePage(
        applicationName: '',
        applicationIcon: SvgPicture.asset('assets/icon/logoTitle.svg'),
      ),
    ),
    GetPage(
      name: Routes.TERMS_OF_SERVICE,
      page: () => const TermsOfServicePage(),
      binding: TermsOfServiceBinding(),
    ),
    GetPage(
      name: Routes.PRIVACY_POLICY,
      page: () => const PrivacyPolicyPage(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(name: Routes.MANUAL, page: () => const ManualPage()),
    GetPage(
        name: Routes.ADMIN,
        page: () => const AdminPage(),
        binding: AdminPageBinding(),
        middlewares: [
          LoginMiddleware(),
          AdminMiddleware(),
        ]),
    GetPage(
        name: Routes.GENERATE_COUPON,
        page: () => const GenerateCouponPage(),
        binding: GenerateCouponPageBinding(),
        middlewares: [
          LoginMiddleware(),
          AdminMiddleware(),
        ]),
    GetPage(
        name: Routes.COUPON,
        page: () => const CouponPage(),
        binding: CouponPageBinding(),
        middlewares: [
          LoginMiddleware(),
          AdminMiddleware(),
        ]),
    GetPage(
        name: Routes.GENERATE_PASSCODE,
        page: () => const GeneratePasscodePage(),
        binding: GeneratePasscodePageBinding(),
        middlewares: [
          LoginMiddleware(),
          AdminMiddleware(),
        ]),
    GetPage(
        name: Routes.PASSCODE,
        page: () => const PasscodePage(),
        binding: PasscodePageBinding(),
        middlewares: [
          LoginMiddleware(),
          AdminMiddleware(),
        ]),
  ];
}
