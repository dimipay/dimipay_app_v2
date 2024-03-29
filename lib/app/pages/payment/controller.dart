import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController {
  final PaymentService paymentService = Get.find<PaymentService>();

  PaymentMethod? get mainPaymentMethod {
    return paymentService.paymentMethods?.firstWhere((element) => element.id == paymentService.mainMethodId);
  }

  @override
  void onInit() {
    super.onInit();
    if (paymentService.paymentMethods == null) {
      paymentService.fetchPaymentMethods();
    }
  }
}
