import 'dart:io';

import 'package:dimipay_app_v2/app/provider/api.dart';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class AppLoader {
  Future<void> load() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await dotenv.load(fileName: "env/.env", isOptional: true);
    Get.lazyPut<ApiProvider>(() => DevApiProvider());
    await initializeDateFormatting('ko_KR');
    await Get.putAsync(() => AuthService().init());
    // 웹에서는 Platform.isAndroid 사용 불가, 부득이하게 이중 If문 사용
    if (Platform.isAndroid) {
      FlutterDisplayMode.setHighRefreshRate();
    }
    FlutterNativeSplash.remove();
  }
}
