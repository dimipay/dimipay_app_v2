import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/network/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkMiddleware extends GetMiddleware {
  final NetworkService networkService = Get.find<NetworkService>();

  NetworkMiddleware({super.priority});

  @override
  GetPage? onPageCalled(GetPage? page) {
    if (!networkService.isOnline) {
      DPErrorSnackBar().open("이 페이지는 인터넷 연결이 필요해요");
      return null;
    }
    return page;
  }
}