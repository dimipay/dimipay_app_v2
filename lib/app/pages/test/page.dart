import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  Widget linkToRoute(String route) {
    return TextButton(
      onPressed: () {
        Get.toNamed(route);
      },
      child: Text(route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route"),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          linkToRoute(Routes.HOME),
          linkToRoute(Routes.LOGIN),
          linkToRoute(Routes.ONBOARDINGPIN),
          linkToRoute(Routes.USER),

          linkToRoute(Routes.TRANSACTION),

          linkToRoute(Routes.INFO),
          linkToRoute(Routes.FACESIGN),
          linkToRoute(Routes.PAYMENT),
          linkToRoute(Routes.REGISTER_CARD),

        ],
      ),
    );
  }
}
