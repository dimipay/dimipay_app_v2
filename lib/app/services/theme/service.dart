import 'package:dimipay_app_v2/app/services/theme/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  late final Rx<ThemeMode> _themeMode;
  ThemeMode get themeMode => _themeMode.value;

  late final ThemeServiceRepository _themeServiceRepository;

  Future<ThemeService> init() async {
    _themeServiceRepository = await ThemeServiceRepository().init();
    _themeMode = Rx(await _themeServiceRepository.getThemeMode());
    if (themeMode == ThemeMode.system) {
      var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.light) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    } else if (themeMode == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    return this;
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    await _themeServiceRepository.setThemeMode(themeMode);

    _themeMode.value = themeMode;
  }

  // void changeTheme(DPTheme newTheme) {
  //   _theme.value = newTheme;
  // }
}
