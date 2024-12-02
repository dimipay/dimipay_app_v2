import 'dart:async';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/provider/providers/dio.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class JWT extends ApiMiddleware {
  AuthService authService = Get.find<AuthService>();

  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) {
    if (authService.jwt.token.accessToken != null) {
      request.headers['Authorization'] = 'Bearer ${authService.jwt.token.accessToken}';
    }
    return next(request);
  }

  @override
  Future<DPHttpResponse?> onError(Exception e, DPHttpRequest request) async {
    DioException dioErr = e as DioException;

    //refresh api가 401시 무한 루프 방지
    if (dioErr.response == null || request.path == '/auth/refresh') {
      return null;
    }

    DPHttpResponse? httpResponse = dioErr.response?.toDPHttpResponse();

    if (dioErr.requestOptions.responseType == ResponseType.stream || httpResponse?.code == 'ERR_TOKEN_EXPIRED') {
      try {
        await authService.jwt.refresh();

        //api 호출을 다시 시도함
        final DPHttpResponse response = await fetch(request);
        return response;
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return null;
      }
    }
    if (httpResponse?.message == '알 수 없는 사용자입니다.' || httpResponse?.code == 'ERR_LOGINED_IN_OTHER_DEVICE') {
      await authService.logout();
      Get.offNamed(Routes.LOGIN);
    }
    return null;
  }

  @override
  JWT copy() {
    return JWT();
  }
}
