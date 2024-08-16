import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  final String? redirect = Get.arguments?['redirect'];
  AuthService authService = Get.find<AuthService>();
  final Rx<bool> _isGoogleLoginInProgress = Rx(false);
  bool get isGoogleLoginInProgress => _isGoogleLoginInProgress.value;

  final RxBool isEmailPasswordLoginVisible = false.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  void showEmailPasswordLogin() {
    isEmailPasswordLoginVisible.value = true;
  }

  void hideEmailPasswordLogin() {
    isEmailPasswordLoginVisible.value = false;
    email.value = '';
    password.value = '';
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  Future loginWithGoogle() async {
    try {
      _isGoogleLoginInProgress.value = true;
      await authService.loginWithGoogle();
      if (authService.isGoogleLoginSuccess) {
        if (authService.isFirstVisit) {
          Get.offNamed(Routes.PIN, arguments: {'pinPageType': PinPageType.register});
        } else {
          Get.toNamed(Routes.PIN, arguments: {'pinPageType': PinPageType.onboarding});
        }
      }
    } on NotDimigoMailException {
      DPErrorSnackBar().open('@dimigo.hs.kr로만 가입할 수 있어요!');
      authService.clearGoogleSignInInfo();
    } on DioException catch (e) {
      DPErrorSnackBar().open(e.response?.data['message'] ?? '');
      authService.clearGoogleSignInInfo();
      rethrow;
    } finally {
      _isGoogleLoginInProgress.value = false;
    }
  }

  Future loginWithPassword() async {
    try {
      await authService.loginWithPassword(email: email.value, password: password.value);
      if (authService.isPasswordLoginSuccess) {
        if (authService.isFirstVisit) {
          Get.offNamed(Routes.PIN, arguments: {'pinPageType': PinPageType.register});
        } else {
          Get.toNamed(Routes.PIN, arguments: {'pinPageType': PinPageType.onboarding});
        }
      }
    } on WrongCredentialsException catch (e) {
      DPErrorSnackBar().open(e.message);
    } on NotPasswordUserException catch (e) {
      DPErrorSnackBar().open(e.message);
    }
  }
}