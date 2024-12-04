import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  Widget linkToRoute(String route) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(route),
    );
  }

  Widget linkToRouteWithArgs(String route, String title, Map<String, dynamic> args) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route, arguments: args);
      },
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Test Page"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Root
          linkToRoute(Routes.HOME),

          // Authentication
          linkToRoute(Routes.LOGIN),
          linkToRoute(Routes.PW_LOGIN),
          linkToRoute(Routes.ONBOARDING),
          linkToRoute(Routes.PIN),
          linkToRouteWithArgs(Routes.PIN, "/edit_pin", {"pinPageType": PinPageType.editPin}),
          linkToRoute(Routes.MANUAL),

          // Main features
          linkToRoute(Routes.PAYMENT),
          linkToRoute(Routes.REGISTER_CARD),
          linkToRoute(Routes.EDIT_CARD),
          linkToRoute(Routes.TRANSACTION),
          linkToRoute(Routes.TRANSACTION_DETAIL),

          // Settings and Info
          linkToRoute(Routes.INFO),
          linkToRoute(Routes.THEME_SELECT),
          linkToRoute(Routes.FACESIGN),
          linkToRoute(Routes.VERSION),
          linkToRoute(Routes.LICENSE),
          linkToRoute(Routes.TERMS_OF_SERVICE),
          linkToRoute(Routes.PRIVACY_POLICY),

          // Admin
          linkToRoute(Routes.ADMIN),
          linkToRoute(Routes.GENERATE_COUPON),
          linkToRoute(Routes.COUPON),
          linkToRoute(Routes.GENERATE_PASSCODE),
          linkToRoute(Routes.PASSCODE),
          linkToRoute(Routes.RESET_PIN),
          linkToRoute(Routes.SYNC_PRODUCT),

          // Miscellaneous
          linkToRoute(Routes.TEST),

          // Utility
          TextButton(
            onPressed: () {
              Get.find<AuthService>().logout();
            },
            child: const Text('log out'),
          ),
          TextButton(
            onPressed: () {
              Get.find<HttpCacheService>().clear();
            },
            child: const Text('clear cache'),
          ),
        ],
      ),
    );
  }
}
