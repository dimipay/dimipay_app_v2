import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/services/face_sign/service.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignPageController extends GetxController with StateMixin {
  final FaceSignService faceSignService = Get.find<FaceSignService>();
  final ImagePicker imagePicker = ImagePicker();

  Future<void> registerFaceSign() async {
    change(null, status: RxStatus.loading());
    try {
      XFile? imageData =
          await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front, maxHeight: 2048, maxWidth: 1024);
      if (imageData != null) {
        await faceSignService.registerFaceSign(imageData);
      }
      change(null, status: RxStatus.success());
    } on FaceSignException catch (e) {
      change(null, status: RxStatus.error(e.message));
      DPErrorSnackBar().open(e.message);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> deleteFaceSign() async {
    await faceSignService.deleteFaceSign();
  }

  @override
  void onInit() {
    super.onInit();
    faceSignService.fetchIsFaceSignRegistered();
    change(null, status: RxStatus.success());
  }
}
