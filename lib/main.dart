import 'package:dimipay_app_v2/app/core/utils/loader.dart';
import 'package:dimipay_app_v2/app/routes/pages.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String getInintialRoute({bool debug = false}) {
  return debug ? Routes.TEST : Routes.HOME;
}

void main() async {
  await AppLoader().load();
  runApp(GetMaterialApp(
    title: '디미페이',
    initialRoute: getInintialRoute(debug: true),
    getPages: AppPages.pages,
    debugShowCheckedModeBanner: false,
  ));
}
