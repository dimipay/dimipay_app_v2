import 'dart:developer';

import 'package:dimipay_app_v2/app/services/push/repository.dart';
import 'package:dimipay_app_v2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushService extends GetxService {
  final PushRepository repository;

  final Duration _expirationPeriod = const Duration(days: 2);

  PushService({PushRepository? repository}) : repository = repository ?? PushRepository();

  Future<PushService> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await repository.updateFcmTokenToServer(fcmToken);
      DateTime now = DateTime.now();
      await repository.setTokenLastUpdated(now);
      log('Registered new fcm token. Token will be expired at ${now.add(_expirationPeriod)}');
    }).onError((err) {
      log('Registering new fcm token failed!');
    });
    await repository.init();

    _isPushTokenExpiredOrNull().then(
      (value) async {
        if (value) {
          await deleteToken();
          await generateToken();
        }
      },
    );

    return this;
  }

  Future<bool> _isPushTokenExpiredOrNull() async {
    DateTime? pushTokenUpdated = await repository.getTokenLastUpdated();
    return pushTokenUpdated == null || DateTime.now().difference(pushTokenUpdated).compareTo(_expirationPeriod) >= 0;
  }

  Future<void> requestPushPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> generateToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
    await repository.deleteTokenLastUpdated();
  }
}
