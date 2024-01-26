import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  Widget linkToRoute(BuildContext context, String route) {
    return TextButton(
      onPressed: () {
        context.push(route);
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
          linkToRoute(context, Routes.HOME),
          linkToRoute(context, Routes.LOGIN),
          linkToRoute(context, Routes.ONBOARDINGPIN),
          linkToRoute(context, Routes.USER),
          linkToRoute(context, Routes.INFO),
        ],
      ),
    );
  }
}
