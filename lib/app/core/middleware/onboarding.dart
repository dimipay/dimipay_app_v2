import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingMiddleware extends GetMiddleware {
  final AuthService authService = Get.find<AuthService>();

  OnboardingMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return authService.isAuthenticated ? null : RouteSettings(name: Routes.PIN, arguments: {'redirect': route, 'pinPageType': PinPageType.onboarding});
  }
}
