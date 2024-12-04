import 'package:dimipay_app_v2/app/services/admin/user/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPinPageController extends GetxController {
  final UserManageService _resetPinService = Get.find<UserManageService>();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final RxBool _isResetPinProgress = false.obs;
  final RxString _email = ''.obs;

  bool get isResetPinProgress => _isResetPinProgress.value;
  bool get isEmailValid => _email.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _setupEmailListener();
  }

  void _setupEmailListener() {
    emailController.addListener(() {
      _email.value = emailController.text;
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.onClose();
  }

  Future<void> resetPin() async {
    _isResetPinProgress.value = true;
    update(['emailField']);

    try {
      await _resetPinService.resetPin(email: emailController.text);
      DPSnackBar.open('핀 초기화에 성공했어요.');
      emailController.clear();
    } catch (e) {
      DPErrorSnackBar().open('핀 초기화에 실패했어요.');
    } finally {
      _isResetPinProgress.value = false;
      update(['emailField']);
    }
  }
}
