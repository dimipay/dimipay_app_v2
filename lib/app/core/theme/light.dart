import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final DPLightTheme _lightTheme = DPLightTheme();

final ThemeData lightThemeData = ThemeData(
  fontFamily: 'SUITv1',
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _lightTheme.colors.primaryBrand,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleSpacing: 0,
    foregroundColor: _lightTheme.colors.grayscale1000,
    centerTitle: false,
  ),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: _lightTheme.colors.primaryBrand.withAlpha(100),
      selectionHandleColor: _lightTheme.colors.primaryBrand),
  cupertinoOverrideTheme:
      CupertinoThemeData(primaryColor: _lightTheme.colors.primaryBrand),
  scaffoldBackgroundColor: _lightTheme.colors.grayscale100,
  extensions: [_lightTheme.colors, _lightTheme.textStyle],
  cardColor: _lightTheme.colors.grayscale100,
);
