import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

import 'package:dimipay_app_v2/app/provider/api_interface.dart';

class HomePageController extends GetxController {

  Future fetchUserInfoIfLoggedIn() async {
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      ApiProvider apiProvider = Get.find<ApiProvider>();
      final response = await apiProvider.get('/user/me');
      dev.log(response.data.toString());
    }
  }

  Future fetchPaymentMethodsIfLoggedIn() async {
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      ApiProvider apiProvider = Get.find<ApiProvider>();
      final response = await apiProvider.get('/payment/method');
      dev.log(response.data.toString());
    }
  }

  Future fetchNoticeIfLoggedIn() async {
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      ApiProvider apiProvider = Get.find<ApiProvider>();
      final response = await apiProvider.get('/notice/current');
      dev.log(response.data.toString());
    }
  }
  }
