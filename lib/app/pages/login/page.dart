import 'package:dimipay_app_v2/app/pages/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends GetView<LoginPageController> {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LogInPage')),
      body: Column(
        children: [
          FilledButton(onPressed: controller.loginWithGoogle, child: const Text('login with google')),
          FilledButton(onPressed: controller.clearTokens, child: const Text('clear tokens')),
        ],
      ),
    );
  }
}
