import 'package:dimipay_app_v2/app/services/face_sign/repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignService extends GetxController {
  final FaceSignRepository repository;
  FaceSignService({FaceSignRepository? repository}) : repository = repository ?? FaceSignRepository();

  Rx<bool> _isRegistered = Rx(false);
  bool get isRegistered => _isRegistered.value;

  Future<void> checkIsRegistered() async {
    _isRegistered.value = await repository.checkFaceSign();
  }

  Future<void> registerFaceSign(XFile image) async {
    final result = await repository.registerFaceSign(image);
    if (result['code'] == "OK") {
      _isRegistered.value = true;
    }
  }

  Future<void> deleteFaceSign() async {
    await repository.deleteFaceSign();
    _isRegistered.value = false;
  }
}
