import 'dart:developer' as dev;
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future fetchUserInfoIfLoggedIn() async {
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      ApiProvider apiProvider = Get.find<ApiProvider>();
      final response = await apiProvider.get('/user/me');
      dev.log(response.data);
    }
  }

  Future fetchPaymentMethodsIfLoggedIn() async {
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      ApiProvider apiProvider = Get.find<ApiProvider>();
      final response = await apiProvider.get('/payment/method');
      dev.log(response.data);
    }
  }

  Future fetchNoticeIfLoggedIn() async {
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      ApiProvider apiProvider = Get.find<ApiProvider>();
      final response = await apiProvider.get('/notice/current');
      dev.log(response.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserInfoIfLoggedIn();
    fetchPaymentMethodsIfLoggedIn();
    fetchNoticeIfLoggedIn();
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Container(),
    );
  }
}
