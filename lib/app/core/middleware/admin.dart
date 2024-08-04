import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMiddleware extends GetMiddleware {
  AdminMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    final UserService userService = Get.find<UserService>();
    return userService.user?.role == 'A' ? null : RouteSettings(name: Routes.HOME, arguments: {'redirect': route});
  }
}
