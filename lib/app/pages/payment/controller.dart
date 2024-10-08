import 'dart:io';

import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/payment/state.dart';
import 'package:dimipay_design_kit/dimipay_design_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPageController extends GetxController {
  final PaymentService paymentService = Get.find<PaymentService>();

  @override
  void onInit() {
    super.onInit();
    if (paymentService.paymentMethodsState is PaymentMethodsStateInitial) {
      paymentService.fetchPaymentMethods();
    }
  }

  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    DPTypography textTheme = Theme.of(Get.context!).extension<DPTypography>()!;
    bool res = false;
    if (Platform.isIOS) {
      res = await showCupertinoDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
          content: const Text('정말 삭제할까요?'),
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
              child: const Text('삭제'),
            ),
          ],
        ),
      );
    } else {
      res = await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          content: const Text('정말 삭제할까요?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('삭제'),
            ),
          ],
        ),
      );
    }
    if (res) {
      await paymentService.deletePaymentMethod(paymentMethod);
    }
  }
}
