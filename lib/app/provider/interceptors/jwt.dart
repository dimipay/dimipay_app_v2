import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/routes/routes.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class JWTInterceptor extends Interceptor {
  final Dio _dioInstance;

  // Dependency Injection
  JWTInterceptor(this._dioInstance);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AuthService authService = Get.find<AuthService>();

    options.headers['Authorization'] ??= 'Bearer ${authService.jwt.token.accessToken}';

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AuthService authService = Get.find<AuthService>();
    //refresh api가 401시 무한 루프 방지

    if (err.response?.requestOptions.path == '/auth/refresh') {
      return handler.next(err);
    }

    if (err.response == null) {
      return handler.next(err);
    }

    if (err.requestOptions.responseType == ResponseType.stream) {
      try {
        await authService.refreshAcessToken();

        //api 호출을 다시 시도함
        err.requestOptions.headers['Authorization'] = null;
        final Response response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return handler.next(err);
      }
    }

    DPHttpResponse httpResponse = DPHttpResponse.fromDioResponse(err.response!);

    if (httpResponse.code == 'ERR_TOKEN_EXPIRED') {
      try {
        await authService.refreshAcessToken();

        //api 호출을 다시 시도함
        err.requestOptions.headers['Authorization'] = null;
        final Response response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return handler.next(err);
      }
    }
    if (httpResponse.message == '알 수 없는 사용자입니다.' || httpResponse.code == 'ERR_LOGINED_IN_OTHER_DEVICE') {
      await authService.logout();
      Get.offNamed(Routes.LOGIN);
    }
    return handler.next(err);
  }
}
