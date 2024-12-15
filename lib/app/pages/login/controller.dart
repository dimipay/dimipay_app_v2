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

  final RxString email = ''.obs;
  final RxString password = ''.obs;

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
    } on DioException catch (e) {
      DPErrorSnackBar().open(e.response?.data['message'] ?? '');
      rethrow;
    } finally {
      _isGoogleLoginInProgress.value = false;
    }
  }
}
