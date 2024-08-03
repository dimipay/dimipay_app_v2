import 'package:dimipay_app_v2/app/pages/info/version/privacy_policy/controller.dart';
import 'package:get/get.dart';

class PrivacyPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyPageController());
  }
}
