import 'dart:async';

import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:flutter/foundation.dart';

abstract class ApiMiddleware {
  @protected
  FutureOr<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next);
  @protected
  FutureOr<DPHttpResponse?> onError(Exception e, DPHttpRequest request) {
    return null;
  }

  late final ApiMiddleware _nextMiddleware;

  ApiMiddleware copy();

  ApiMiddleware setNextMiddleware(ApiMiddleware middleware) {
    _nextMiddleware = middleware;
    return this;
  }

  Future<DPHttpResponse> fetch(DPHttpRequest request) async {
    try {
      return await handle(request, (req) => _nextMiddleware.fetch(request));
    } on Exception catch (e) {
      DPHttpResponse? response = await onError(e, request);
      if (response != null) {
        return response;
      }
      rethrow;
    }
  }
}
