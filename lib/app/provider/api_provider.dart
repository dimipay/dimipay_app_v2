import 'dart:async';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:flutter/foundation.dart';

class PerformApiRequestMiddleware extends ApiMiddleware {
  final Future<DPHttpResponse> Function(DPHttpRequest) performApiRequest;

  PerformApiRequestMiddleware(this.performApiRequest);

  @override
  FutureOr<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) {
    return performApiRequest(request);
  }

  @override
  PerformApiRequestMiddleware copy() {
    return PerformApiRequestMiddleware(performApiRequest);
  }
}

abstract class ApiProvider {
  final List<ApiMiddleware> middlewares = [];

  @nonVirtual
  @protected
  ApiMiddleware decorateWithMiddlewares(Future<DPHttpResponse> Function(DPHttpRequest request) performApiRequest, List<ApiMiddleware> requestMiddlewares) {
    ApiMiddleware middleware = PerformApiRequestMiddleware(performApiRequest);

    List<ApiMiddleware> globalMiddlewares = middlewares.map((e) => e.copy()).toList();
    List<ApiMiddleware> completeMiddlewares = globalMiddlewares + requestMiddlewares;

    for (var i = completeMiddlewares.length - 1; i >= 0; i--) {
      middleware = completeMiddlewares[i].setNextMiddleware(middleware);
    }

    return middleware;
  }

  @nonVirtual
  Future<DPHttpResponse> get(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = decorateWithMiddlewares(performGetRequest, middlewares);

    request.method = 'GET';

    return middleware.fetch(request);
  }

  @nonVirtual
  Future<DPHttpResponse> post(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = decorateWithMiddlewares(performPostRequest, middlewares);

    request.method = 'POST';

    return middleware.fetch(request);
  }

  Future<DPHttpResponse> patch(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = decorateWithMiddlewares(performPatchRequest, middlewares);

    request.method = 'PATCH';

    return middleware.fetch(request);
  }

  Future<DPHttpResponse> put(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = decorateWithMiddlewares(performPutRequest, middlewares);

    request.method = 'PUT';

    return middleware.fetch(request);
  }

  Future<DPHttpResponse> delete(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = decorateWithMiddlewares(performDeleteRequest, middlewares);

    request.method = 'DELETE';

    return middleware.fetch(request);
  }

  @protected
  Future<DPHttpResponse> performGetRequest(DPHttpRequest request);

  @protected
  Future<DPHttpResponse> performPostRequest(DPHttpRequest request);

  @protected
  Future<DPHttpResponse> performPatchRequest(DPHttpRequest request);

  @protected
  Future<DPHttpResponse> performPutRequest(DPHttpRequest request);

  @protected
  Future<DPHttpResponse> performDeleteRequest(DPHttpRequest request);
}
