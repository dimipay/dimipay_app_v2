import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  UserService userService = Get.find<UserService>();
  PaymentService paymentService = Get.find<PaymentService>();

  @override
  void onInit() {
    userService.fetchUser();
    paymentService.fetchPaymentMethods();
    super.onInit();
  }
}
