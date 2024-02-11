import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class InfoPageController extends GetxController {
  UserService userService = Get.find<UserService>();
  AuthService authService = Get.find<AuthService>();
  PaymentService paymentService = Get.find<PaymentService>();
  FaceSignService faceSignService = Get.find<FaceSignService>();

  @override
  void onInit() {
    if (userService.user == null) {
      userService.fetchUser();
    }
    if (paymentService.paymentMethods == null) {
      paymentService.fetchPaymentMethods();
    }
    faceSignService.fetchIsFaceSignRegistered();
    super.onInit();
  }

  void logout() async {
    await authService.logout();
    Get.offAllNamed(Routes.LOGIN);
  }
}
