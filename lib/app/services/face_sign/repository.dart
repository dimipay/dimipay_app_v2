import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignRepository {
  final ApiProvider api;

  FaceSignRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<bool> checkIfFaceSignRegistered() async {
    String url = '/user/me/face-registered';
    Response response = await api.get(url);
    return response.data['registered'];
  }

  Future<void> registerFaceSign(XFile file) async {
    String url = '/auth/face';

    MultipartFile faceSign = await MultipartFile.fromFile(file.path);
    try {
      await api.post(url,
          data: FormData.fromMap({
            'image': faceSign,
          }));

      return;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_FACE_REGISTER_FAILED') {
        throw FaceSignException(e.response?.data['message']);
      }
      rethrow;
    }
  }

  Future<void> deleteFaceSign() async {
    String url = '/auth/face';

    await api.delete(url);
  }
}
