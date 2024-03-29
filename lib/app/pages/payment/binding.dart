import 'package:dimipay_app_v2/app/pages/payment/controller.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:get/get.dart';

class PaymentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(() => PaymentService());
    Get.lazyPut<OnboardingPageController>(() => OnboardingPageController());
  }
}
