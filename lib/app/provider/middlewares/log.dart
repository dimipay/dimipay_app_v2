import 'dart:async';

import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';

class LogMiddleware extends ApiMiddleware {
  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) async {
    DPHttpResponse response = await next(request);
    dev.log('${request.method}[${response.statusCode}] => PATH: ${request.path}', name: 'DIO');

    return response;
  }

  @override
  FutureOr<DPHttpResponse?> onError(Exception e, DPHttpRequest request) {
    DioException dioException = e as DioException;
    dev.log('ERROR : ${request.method}[${dioException.response?.statusCode}] => PATH: ${request.path}', name: 'DIO');
  }

  @override
  ApiMiddleware copy() {
    return LogMiddleware();
  }
}
