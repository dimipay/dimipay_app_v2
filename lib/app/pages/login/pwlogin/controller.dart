import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PWLoginPageController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  final Rx<bool> _isLoginInProgress = Rx(false);

  bool get isLoginInProgress => _isLoginInProgress.value;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    emailFocusNode.addListener(() {
      update(['emailField']);
    });
    passwordFocusNode.addListener(() {
      update(['passwordField']);
    });
  }

  Future loginWithPassword() async {
    try {
      _isLoginInProgress.value = true;
      await authService.loginWithPassword(
          email: emailController.text, password: pwController.text);
      if (authService.isPasswordLoginSuccess) {
        if (authService.isFirstVisit) {
          Get.offNamed(Routes.PIN,
              arguments: {'pinPageType': PinPageType.register});
        } else {
          Get.toNamed(Routes.PIN,
              arguments: {'pinPageType': PinPageType.onboarding});
        }
      }
    } on WrongCredentialsException catch (e) {
      DPErrorSnackBar().open(e.message);
    } on NotPasswordUserException catch (e) {
      DPErrorSnackBar().open(e.message);
    } catch (e) {
      DPErrorSnackBar().open('이메일 형식이 잘못되었어요.');
    } finally {
      _isLoginInProgress.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
