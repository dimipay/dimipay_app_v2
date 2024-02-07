import 'package:dimipay_app_v2/app/pages/pin/controller.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dimipay_app_v2/app/services/pay/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  UserService userService = Get.find<UserService>();
  PaymentService paymentService = Get.find<PaymentService>();
  AuthService authService = Get.find<AuthService>();
  PayService payService = Get.find<PayService>();

  @override
  void onInit() {
    userService.fetchUser();
    paymentService.fetchPaymentMethods().then((_) => tryRequestQR());
    super.onInit();
  }

  Future<void> tryRequestQR() async {
    if (paymentService.mainMethod == null) {
      return;
    }
    if (authService.pin == null) {
      final res = await showPinDialog();

      if (res == null) {
        return;
      }
    }
    await payService.fetchPaymentToken(paymentService.mainMethod!);
  }
}
