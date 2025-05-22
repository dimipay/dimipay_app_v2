import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/enc.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/auth/service.dart';
import 'package:get/get.dart';

class OTP extends ApiMiddleware {
  Future<String> getPinOTP() async {
    String url = '/pin/otp';
    AuthService authService = Get.find<AuthService>();

    Map<String, dynamic> body = {};

    if (authService.pin != null) {
      body['pin'] = authService.pin;
    }
    if (authService.pin == null && authService.bioKey.key != null) {
      body['bioKey'] = authService.bioKey.key;
    }

    Map<String, dynamic> headers = {};
    if (authService.isAuthenticated == false) {
      headers['Authorization'] = 'Bearer ${authService.onboardingToken.accessToken}';
    }

    DPHttpResponse response = await Get.find<ApiProvider>().post(DPHttpRequest(url, body: body, headers: headers), [JWT(), EncryptBody()]);
    return response.data['otp'];
  }

  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) async {
    String otp = await getPinOTP();
    request.headers['Payment-Pin-Otp'] = otp;
    return next(request);
  }

  @override
  ApiMiddleware copy() {
    return OTP();
  }
}
