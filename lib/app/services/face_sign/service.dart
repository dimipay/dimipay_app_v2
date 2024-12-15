import 'package:dimipay_app_v2/app/core/utils/async.dart';
import 'package:dimipay_app_v2/app/services/face_sign/repository.dart';
import 'package:dimipay_app_v2/app/services/face_sign/state.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceSignService extends GetxController {
  final FaceSignRepository repository;
  FaceSignService({FaceSignRepository? repository}) : repository = repository ?? FaceSignRepository();

  final Rx<FaceSignState> _faceSignState = Rx(const FaceSignStateInitial());
  FaceSignState get faceSignState => _faceSignState.value;

  Future<void> fetchIsFaceSignRegistered() async {
    _faceSignState.value = const FaceSignStateLoading();
    return anySuccess([_fetchFaceSignStateFromCache(), _fetchFaceSignStateFromRemote()]);
  }

  Future<void> _fetchFaceSignStateFromCache() async {
    bool data = await repository.getFaceSignStateFromCache();

    if (faceSignState is! FaceSignStateSuccess) {
      _faceSignState.value = FaceSignStateSuccess(isRegistered: data);
    }
  }

  Future<void> _fetchFaceSignStateFromRemote() async {
    try {
      bool data = await repository.getFaceSignState();

      _faceSignState.value = FaceSignStateSuccess(isRegistered: data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return;
      }
      _faceSignState.value = FaceSignStateFailed(exception: e);
    }
  }

  Future<void> registerFaceSign(XFile image) async {
    try {
      _faceSignState.value = const FaceSignStateLoading();
      await repository.registerFaceSign(image);
      _faceSignState.value = const FaceSignStateSuccess(isRegistered: true);
      repository.saveCurrentStateToCache(true);
    } on Exception catch (e) {
      _faceSignState.value = FaceSignStateFailed(exception: e);
      rethrow;
    }
  }

  Future<void> patchFaceSign(XFile image) async {
    if (faceSignState is FaceSignStateSuccess && (faceSignState as FaceSignStateSuccess).isRegistered == false) {
      return;
    }
    try {
      _faceSignState.value = const FaceSignStatePatching();
      await repository.patchFaceSign(image);
      _faceSignState.value = const FaceSignStateSuccess(isRegistered: true);
    } on Exception catch (_) {
      _faceSignState.value = const FaceSignStateSuccess(isRegistered: true);
      rethrow;
    }
  }

  Future<void> deleteFaceSign() async {
    try {
      _faceSignState.value = const FaceSignStateSuccess(isRegistered: false);
      await repository.deleteFaceSign();
      repository.saveCurrentStateToCache(false);
    } catch (e) {
      _faceSignState.value = const FaceSignStateSuccess(isRegistered: true);
      rethrow;
    }
  }
}
