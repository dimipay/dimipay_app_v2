import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/services/admin/reset_pin/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPinPageController extends GetxController {
  final UserManageService resetPinService = Get.find<UserManageService>();

  TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final RxBool _isResetPinProgress = false.obs;

  bool get isResetPinProgress => _isResetPinProgress.value;

  Future<void> resetPin() async {
    if (emailController.text.isEmpty) {
      DPErrorSnackBar().open('이메일을 입력해주세요.');
      return;
    }

    _isResetPinProgress.value = true;
    update(['emailField']);

    try {
      await resetPinService.resetPin(email: emailController.text);
      DPSnackBar.open('핀 초기화에 성공했습니다.');
      emailController.clear();
    } on ResetPinException catch (e) {
      DPErrorSnackBar().open(e.message);
    } catch (e) {
      DPErrorSnackBar().open('핀 초기화에 실패했습니다.');
    } finally {
      _isResetPinProgress.value = false;
      update(['emailField']);
    }
  }
}
