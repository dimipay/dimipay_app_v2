import 'package:dimipay_app_v2/app/services/face_sign/repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignService extends GetxController {
  final FaceSignRepository repository;
  FaceSignService({FaceSignRepository? repository}) : repository = repository ?? FaceSignRepository();

  final Rx<bool> _isRegistered = Rx(false);
  bool get isRegistered => _isRegistered.value;

  Future<void> fetchIsFaceSignRegistered() async {
    _isRegistered.value = await repository.checkIfFaceSignRegistered();
  }

  Future<void> registerFaceSign(XFile image) async {
    await repository.registerFaceSign(image);
    _isRegistered.value = true;
  }

  Future<void> deleteFaceSign() async {
    await repository.deleteFaceSign();
    _isRegistered.value = false;
  }
}
