import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:get/get.dart';

class PaymentPageController extends GetxController {
  final PaymentService paymentService = Get.find<PaymentService>();

  @override
  void onInit() {
    super.onInit();
    if (paymentService.paymentMethods == null) {
      paymentService.fetchPaymentMethods();
    }
  }
}
