import 'package:dimipay_app_v2/app/pages/face_sign/controller.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:get/get.dart';

class FaceSignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceSignService>(() => FaceSignService());
    Get.lazyPut<FaceSignPageController>(() => FaceSignPageController());
  }
}
