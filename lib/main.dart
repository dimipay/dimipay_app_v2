import 'package:dimipay_app_v2/app/core/utils/loader.dart';
import 'package:dimipay_app_v2/app/routes/pages.dart';
import 'package:dimipay_design_kit/utils/dimipay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await AppLoader().load();
  runApp(MaterialApp.router(
    title: '디미페이',
    routeInformationParser: router.routeInformationParser,
    routeInformationProvider: router.routeInformationProvider,
    routerDelegate: router.routerDelegate,
    backButtonDispatcher: router.backButtonDispatcher,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: DPColors.primaryBrand),
      useMaterial3: true,
      fontFamily: 'SUITv1',
      primaryColor: DPColors.primaryBrand,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        foregroundColor: DPColors.grayscale1000,
        centerTitle: false,
      ),
      scaffoldBackgroundColor: DPColors.grayscale100,
    ),
  ));
}
