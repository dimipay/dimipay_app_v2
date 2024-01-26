import 'package:dimipay_app_v2/app/pages/home/controller.dart';
import 'package:dimipay_app_v2/app/pages/home/page.dart';
import 'package:dimipay_app_v2/app/pages/info/controller.dart';
import 'package:dimipay_app_v2/app/pages/info/page.dart';
import 'package:dimipay_app_v2/app/pages/login/controller.dart';
import 'package:dimipay_app_v2/app/pages/login/page.dart';
import 'package:dimipay_app_v2/app/pages/onboarding_pin/controller.dart';
import 'package:dimipay_app_v2/app/pages/onboarding_pin/page.dart';
import 'package:dimipay_app_v2/app/pages/test/page.dart';
import 'package:dimipay_app_v2/app/pages/user/controller.dart';
import 'package:dimipay_app_v2/app/pages/user/page.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

String getInitialRoute({bool debug = false}) {
  return debug ? Routes.TEST : Routes.HOME;
}

final GoRouter router = GoRouter(
  initialLocation: getInitialRoute(debug: kDebugMode),
  routes: [
    GoRoute(
      path: Routes.TEST,
      builder: (context, state) => const TestPage(),
    ),
    GoRoute(
      path: Routes.HOME,
      builder: (context, state) => GetBuilder(
        init: HomePageController(),
        dispose: (state) {
          Get.delete<HomePageController>();
        },
        builder: (controller) => const HomePage(),
      ),
    ),
    GoRoute(
      path: Routes.LOGIN,
      builder: (context, state) => GetBuilder(
        init: LoginPageController(),
        dispose: (state) {
          Get.delete<LoginPageController>();
        },
        builder: (controller) => const LogInPage(),
      ),
    ),
    GoRoute(
      path: Routes.ONBOARDINGPIN,
      builder: (context, state) => GetBuilder(
        init: OnboardingPageController(),
        dispose: (state) {
          Get.delete<OnboardingPageController>();
        },
        builder: (controller) => const OnboardingPinPage(),
      ),
    ),
    GoRoute(
      path: Routes.USER,
      builder: (context, state) => GetBuilder(
        init: UserPageController(),
        dispose: (state) {
          Get.delete<UserPageController>();
        },
        builder: (controller) => const UserPage(),
      ),
    ),
    GoRoute(
      path: Routes.INFO,
      builder: (context, state) => GetBuilder(
        init: InfoPageController(),
        dispose: (state) {
          Get.delete<InfoPageController>();
        },
        builder: (controller) => const InfoPage(),
      ),
    ),
  ],
);