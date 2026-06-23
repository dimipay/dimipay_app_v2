import 'package:dimipay_app_v2/app/services/api_url/manager.dart';
import 'package:dimipay_app_v2/app/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/providers/dio.dart';

class ApiUrlSettingsPageController extends GetxController {
  final ApiUrlManager _apiUrlManager = Get.find<ApiUrlManager>();
  final TextEditingController urlController = TextEditingController();
  final FocusNode urlFocusNode = FocusNode();

  final RxBool _isSaving = false.obs;
  final RxString _url = ''.obs;

  bool get isSaving => _isSaving.value;
  bool get isUrlValid => _url.value.isNotEmpty;
  String get currentUrl => _apiUrlManager.apiUrl ?? 'https://prod-next.dimipay.io/';

  @override
  void onInit() {
    super.onInit();
    _setupUrlListener();
    // 현재 API URL을 텍스트 필드에 표시
    urlController.text = currentUrl;
  }

  void _setupUrlListener() {
    urlController.addListener(() {
      _url.value = urlController.text;
    });
  }

  @override
  void onClose() {
    urlController.dispose();
    urlFocusNode.dispose();
    super.onClose();
  }

  Future<void> saveUrl() async {
    _isSaving.value = true;
    update(['urlField']);

    try {
      String newUrl = urlController.text.trim();

      // URL 형식 검증
      if (!newUrl.startsWith('http://') && !newUrl.startsWith('https://')) {
        DPErrorSnackBar().open('올바른 URL 형식이 아니에요. (http:// 또는 https://로 시작해야 합니다)');
        return;
      }

      // URL 끝에 슬래시 추가 (없는 경우)
      if (!newUrl.endsWith('/')) {
        newUrl = '$newUrl/';
      }

      // API URL 저장
      await _apiUrlManager.setUrl(newUrl);

      // Dio 인스턴스의 baseUrl 업데이트
      final ApiProvider apiProvider = Get.find<ApiProvider>();
      if (apiProvider is DioApiProvider) {
        apiProvider.dio.options.baseUrl = newUrl;
      }

      DPSnackBar.open('API URL이 변경되었어요. 앱을 재시작해주세요.');
    } on Exception {
      DPErrorSnackBar().open('API URL 저장에 실패했어요.');
    } finally {
      _isSaving.value = false;
      update(['urlField']);
    }
  }

  Future<void> resetToDefault() async {
    const String defaultUrl = 'https://prod-next.dimipay.io/';
    urlController.text = defaultUrl;
    await _apiUrlManager.clear();

    // Dio 인스턴스의 baseUrl 업데이트
    final ApiProvider apiProvider = Get.find<ApiProvider>();
    if (apiProvider is DioApiProvider) {
      apiProvider.dio.options.baseUrl = defaultUrl;
    }

    DPSnackBar.open('기본 URL로 초기화되었어요.');
  }
}