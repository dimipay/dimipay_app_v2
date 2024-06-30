import 'dart:developer';

import 'package:dimipay_app_v2/app/services/push/repository.dart';
import 'package:dimipay_app_v2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushService extends GetxService {
  final PushRepository repository;
  PushService({PushRepository? repository}) : repository = repository ?? PushRepository();

  Future<PushService> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await repository.updateFcmToken(fcmToken);
      log('Registered new fcm token...');
    }).onError((err) {
      log('Registering new fcm token failed!');
    });
    return this;
  }

  Future<void> requestPushPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> generateToken() async {
    await FirebaseMessaging.instance.getToken();
  }

  Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }
}
