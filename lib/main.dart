import 'package:dimipay_app_v2/app/core/theme/dark.dart';
import 'package:dimipay_app_v2/app/core/theme/light.dart';
import 'package:dimipay_app_v2/app/core/utils/loader.dart';
import 'package:dimipay_app_v2/app/routes/pages.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/theme/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String getInintialRoute({bool debug = false}) {
  return debug ? Routes.TEST : Routes.HOME;
}

void main() async {
  await AppLoader().load();
  runApp(
    Obx(
      () {
        ThemeService themeService = Get.find<ThemeService>();
        return GetMaterialApp(
          title: '디미페이',
          initialRoute: getInintialRoute(debug: kDebugMode),
          getPages: AppPages.pages,
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: themeService.themeMode,
        );
      },
    ),
  );
}
