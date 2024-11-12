import 'dart:async';

import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class JWTMiddleware extends ApiMiddleware {
  JWTMiddleware();

  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) {
    AuthService authService = Get.find<AuthService>();
    if (authService.jwt.token.accessToken != null) {
      request.headers['Authorization'] = 'Bearer ${authService.jwt.token.accessToken}';
    }
    return next(request);
  }

  @override
  Future<DPHttpResponse?> onError(Exception e, DPHttpRequest request) async {
    DioException dioErr = e as DioException;

    AuthService authService = Get.find<AuthService>();
    //refresh api가 401시 무한 루프 방지

    if (dioErr.response == null || request.path == '/auth/refresh') {
      return null;
    }

    if (dioErr.requestOptions.responseType == ResponseType.stream) {
      try {
        await authService.refreshAcessToken();

        //api 호출을 다시 시도함
        final DPHttpResponse response = await fetch(request);
        return response;
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return null;
      }
    }

    DPHttpResponse httpResponse = DPHttpResponse.fromDioResponse(dioErr.response!);

    if (httpResponse.code == 'ERR_TOKEN_EXPIRED') {
      try {
        await authService.refreshAcessToken();

        //api 호출을 다시 시도함
        final DPHttpResponse response = await fetch(request);
        return response;
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return null;
      }
    }
    if (httpResponse.message == '알 수 없는 사용자입니다.' || httpResponse.code == 'ERR_LOGINED_IN_OTHER_DEVICE') {
      await authService.logout();
      Get.offNamed(Routes.LOGIN);
    }
    return null;
  }
}
