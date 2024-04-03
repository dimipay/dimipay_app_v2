import 'package:dimipay_app_v2/app/core/utils/errors.dart';
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

  Future loginWithGoogle() async {
    try {
      _isGoogleLoginInProgress.value = true;
      await authService.loginWithGoogle();
      if (authService.isGoogleLoginSuccess) {
        if (authService.isFirstVisit) {
          Get.toNamed(Routes.ONBOARDING, arguments: {'redirect': redirect});
        } else {
          final String nextRoute = redirect ?? Routes.HOME;
          Get.toNamed(nextRoute);
        }
      }
    } on NotDimigoMailExceptoin {
      DPErrorSnackBar().open('@dimigo.hs.kr로만 가입할 수 있어요!');
    } on DioException catch (e) {
      DPErrorSnackBar().open(e.response?.data['message'] ?? '');
    } finally {
      _isGoogleLoginInProgress.value = false;
    }
  }
}
