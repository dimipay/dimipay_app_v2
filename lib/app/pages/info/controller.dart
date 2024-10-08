import 'dart:io';

import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:dimipay_app_v2/app/services/user/state.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPageController extends GetxController {
  UserService userService = Get.find<UserService>();
  AuthService authService = Get.find<AuthService>();
  PaymentService paymentService = Get.find<PaymentService>();
  FaceSignService faceSignService = Get.find<FaceSignService>();

  @override
  void onInit() {
    if (userService.userState is UserStateInitial) {
      userService.fetchUser();
    }
    if (paymentService.paymentMethodsState is PaymentMethodsStateInitial) {
      paymentService.fetchPaymentMethods();
    }
    faceSignService.fetchIsFaceSignRegistered();
    super.onInit();
  }

  void logout() async {
    DPTypography textTheme = Theme.of(Get.context!).extension<DPTypography>()!;
    bool res = false;
    if (Platform.isIOS) {
      res = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          content: const Text('정말 로그아웃 하시겠어요?'),
          actions: [
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () => Get.back(result: false),
              child: Text('취소', style: textTheme.paragraph1.copyWith(color: Colors.blue)),
            ),
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () => Get.back(result: true),
              child: const Text('로그아웃'),
            ),
          ],
        ),
      );
    } else {
      res = await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          content: const Text('정말 로그아웃 하시겠어요?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('로그아웃'),
            ),
          ],
        ),
      );
    }
    if (res) {
      await authService.logout();
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void openTermsOfServiceAndPrivacyPolicy() {
    Get.toNamed(Routes.PRIVACY_POLICY);
    Get.toNamed(Routes.TERMS_OF_SERVICE);
  }
}
