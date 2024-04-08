import 'package:dimipay_app_v2/app/pages/terms_of_service/controller.dart';
import 'package:get/get.dart';

class TermsOfServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsOfServicePageController());
  }
}
