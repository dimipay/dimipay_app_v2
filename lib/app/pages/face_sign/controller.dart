import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignPageController extends GetxController {
  final FaceSignService faceSignService = Get.find<FaceSignService>();
  final ImagePicker imagePicker = ImagePicker();

  Future<void> registerFaceSign() async {
    try {
      XFile? imageData =
          await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, maxHeight: 2048, maxWidth: 1024);
      if (imageData != null) {
        await faceSignService.registerFaceSign(imageData);
      }
    } on FaceSignException catch (e) {
      DPErrorSnackBar().open(e.message);
    }
  }

  Future<void> deleteFaceSign() async {
    await faceSignService.deleteFaceSign();
  }

  @override
  void onInit() async {
    await faceSignService.checkIsRegistered();
    super.onInit();
  }
}
