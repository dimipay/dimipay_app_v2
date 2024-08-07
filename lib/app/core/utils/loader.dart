import 'dart:io';
import 'package:dimipay_app_v2/app/provider/api.dart';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/theme/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppLoader {
  Future<void> load() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    
    if (kReleaseMode) {
      Get.lazyPut<SecureApiProvider>(() => ProdSecureApiProvider());
    } else {
      Get.lazyPut<SecureApiProvider>(() => DevSecureApiProvider());
    }

    await dotenv.load(fileName: "env/.env", isOptional: true);
    await Hive.initFlutter();
    await Get.putAsync(ThemeService().init);
    await Get.putAsync(AuthService().init);

    await initializeDateFormatting('ko_KR');

    if (Platform.isAndroid) {
      FlutterDisplayMode.setHighRefreshRate();
    }

    FlutterNativeSplash.remove();
  }
}
