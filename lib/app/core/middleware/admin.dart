import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMiddleware extends GetMiddleware {
  AdminMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    final UserState userState = Get.find<UserService>().userState;
    if (userState is UserStateSuccess && userState.user.role == 'A') {
      return null;
    }
    return RouteSettings(name: Routes.HOME, arguments: {'redirect': route});
  }
}
