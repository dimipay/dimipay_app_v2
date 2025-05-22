import 'package:dimipay_app_v2/app/pages/info/controller.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:dimipay_app_v2/app/services/payment/service.dart';
import 'package:dimipay_app_v2/app/services/user/service.dart';
import 'package:get/get.dart';

class InfoPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfoPageController());
    Get.lazyPut(() => UserService());
    Get.put(PaymentService());
    Get.put(FaceSignService());
  }
}
