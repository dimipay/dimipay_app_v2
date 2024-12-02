import 'package:dimipay_app_v2/app/core/utils/errors.dart';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/from_cache.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/save_cache.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/provider/providers/dio.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class FaceSignRepository {
  final ApiProvider api;

  FaceSignRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<bool> getFaceSignState() async {
    String url = '/face-sign';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWT(), SaveCache()]);
    return response.data['registered'];
  }

  Future<bool> getFaceSignStateFromCache() async {
    String url = '/face-sign';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [FromCache()]);
    return response.data['registered'];
  }

  Future<void> saveCurrentStateToCache(bool isRegisterd) async {
    String url = '/face-sign';
    HttpCacheService cacheService = Get.find<HttpCacheService>();

    Map<String, dynamic> data = {
      'registered': isRegisterd,
    };

    await cacheService.save(
        DPHttpRequest(url, method: 'GET'),
        DPHttpResponse(
          requredId: '',
          code: 'OK',
          statusCode: 200,
          timeStamp: DateTime.now().toString(),
          data: data,
        ));
  }

  Future<void> registerFaceSign(XFile file) async {
    String url = '/face-sign';

    MultipartFile faceSign = await MultipartFile.fromFile(file.path, contentType: MediaType('image', 'jpeg'));
    try {
      await api.post(DPHttpRequest(url, body: FormData.fromMap({'image': faceSign})), [JWT()]);

      return;
    } on DioException catch (e) {
      DPHttpResponse response = e.response!.toDPHttpResponse();
      if (response.code == 'ERR_FAILED_TO_REGISTER_FACE_SIGN') {
        throw FaceSignException(response.message!);
      }
      rethrow;
    }
  }

  Future<void> patchFaceSign(XFile file) async {
    String url = '/face-sign';

    MultipartFile faceSign = await MultipartFile.fromFile(file.path, contentType: MediaType('image', 'jpeg'));
    try {
      await api.put(DPHttpRequest(url, body: FormData.fromMap({'image': faceSign})), [JWT()]);

      return;
    } on DioException catch (e) {
      if (e.response?.data['code'] == 'ERR_FACE_REGISTER_FAILED') {
        throw FaceSignException(e.response?.data['message']);
      }
      rethrow;
    }
  }

  Future<void> deleteFaceSign() async {
    String url = '/face-sign';

    await api.delete(DPHttpRequest(url), [JWT()]);
  }
}
