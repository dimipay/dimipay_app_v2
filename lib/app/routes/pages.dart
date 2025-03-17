import 'package:dimipay_app_v2/app/core/middleware/admin.dart';
import 'package:dimipay_app_v2/app/core/middleware/login.dart';
import 'package:dimipay_app_v2/app/core/middleware/network.dart';
import 'package:dimipay_app_v2/app/core/middleware/onboarding.dart';
import 'package:dimipay_app_v2/app/pages/admin/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/cancel_transaction/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/cancel_transaction/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/coupon/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_coupon/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/passcode/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/generate_passcode/passcode/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/reset_pin/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/reset_pin/page.dart';
import 'package:dimipay_app_v2/app/pages/admin/sync_product/binding.dart';
import 'package:dimipay_app_v2/app/pages/admin/sync_product/page.dart';
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
import 'package:dimipay_app_v2/app/pages/info/version/terms_of_service/binding.dart';
import 'package:dimipay_app_v2/app/pages/info/version/terms_of_service/page.dart';
import 'package:dimipay_app_v2/app/pages/login/binding.dart';
import 'package:dimipay_app_v2/app/pages/login/page.dart';
import 'package:dimipay_app_v2/app/pages/login/pwlogin/binding.dart';
import 'package:dimipay_app_v2/app/pages/login/pwlogin/page.dart';
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
    // Root
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomePageBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware()],
      transition: Transition.noTransition,
    ),

    // Authentication
    GetPage(
      name: Routes.LOGIN,
      page: () => const LogInPage(),
      binding: LoginPageBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.PW_LOGIN,
      page: () => const PWLoginPage(),
      binding: PWLoginPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PIN,
      page: () => const PinPage(),
      binding: PinPageBinding(),
      middlewares: [LoginMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingPage(),
      binding: OnboardingPageBinding(),
      middlewares: [LoginMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.MANUAL,
      page: () => const ManualPage(),
      transition: Transition.cupertino,
    ),

    // Main features
    GetPage(
      name: Routes.PAYMENT,
      page: () => const PaymentPage(),
      binding: PaymentPageBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.REGISTER_CARD,
      page: () => const RegisterCardPage(),
      binding: RegisterCardPageBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.EDIT_CARD,
      page: () => const EditCardPage(),
      binding: EditCardPageBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => const TransactionPage(),
      binding: TransactionPageBinding(),
      middlewares: [NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.TRANSACTION_DETAIL,
      page: () => const TransactionDetailPage(),
      binding: TransactionDetailPageBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),

    // Settings and Info
    GetPage(
      name: Routes.INFO,
      page: () => const InfoPage(),
      binding: InfoPageBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.FACESIGN,
      page: () => const FaceSignPage(),
      binding: FaceSignBinding(),
      middlewares: [LoginMiddleware(), OnboardingMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.THEME_SELECT,
      page: () => const ThemeSelectPage(),
      binding: ThemeSelectPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.VERSION,
      page: () => const VersionPage(),
      binding: VersionPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.LICENSE,
      page: () => LicensePage(
        applicationName: '',
        applicationIcon: SvgPicture.asset('assets/icon/logoTitle.svg'),
      ),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.TERMS_OF_SERVICE,
      page: () => const TermsOfServicePage(),
      binding: TermsOfServiceBinding(),
      transition: Transition.cupertino,
    ),

    // Admin
    GetPage(
      name: Routes.ADMIN,
      page: () => const AdminPage(),
      binding: AdminPageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.GENERATE_COUPON,
      page: () => const GenerateCouponPage(),
      binding: GenerateCouponPageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.COUPON,
      page: () => const CouponPage(),
      binding: CouponPageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.GENERATE_PASSCODE,
      page: () => const GeneratePasscodePage(),
      binding: GeneratePasscodePageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PASSCODE,
      page: () => const PasscodePage(),
      binding: PasscodePageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.RESET_PIN,
      page: () => const ResetPinPage(),
      binding: ResetPinPageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.SYNC_PRODUCT,
      page: () => const SyncProductPage(),
      binding: SyncProductPageBinding(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.CANCEL_TRANSACTION,
      binding: CancelTransactionBinding(),
      page: () => const CancelTransactionPage(),
      middlewares: [LoginMiddleware(), AdminMiddleware(), NetworkMiddleware()],
      transition: Transition.cupertino,
    ),

    // Miscellaneous
    GetPage(
      name: Routes.TEST,
      page: () => const TestPage(),
      transition: Transition.cupertino,
    ),
  ];
}
