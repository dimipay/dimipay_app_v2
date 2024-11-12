import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'dart:developer' as dev;

class LogMiddleware extends ApiMiddleware {
  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) async {
    DPHttpResponse response = await next(request);
    dev.log('${request.method}[${response.statusCode}] => PATH: ${request.path}', name: 'DIO');

    return response;
  }
}
