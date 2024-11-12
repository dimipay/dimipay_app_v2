import 'dart:async';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:flutter/foundation.dart';

class PerformApiRequestMiddleware extends ApiMiddleware {
  final Future<DPHttpResponse> Function(DPHttpRequest request) performApiRequest;

  PerformApiRequestMiddleware(this.performApiRequest);

  @override
  FutureOr<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest p1) next) {
    return performApiRequest(request);
  }

  @override
  Future<DPHttpResponse> fetch(DPHttpRequest request) {
    return performApiRequest(request);
  }
}

abstract class ApiProvider {
  @nonVirtual
  ApiMiddleware decorateMiddlewares(ApiMiddleware request, List<ApiMiddleware> middlewares) {
    ApiMiddleware middleware = request;

    for (var i = middlewares.length - 1; i >= 0; i--) {
      middleware = middlewares[i].setNextMiddleware(middleware);
    }

    return middleware;
  }

  @nonVirtual
  Future<DPHttpResponse> get(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = PerformApiRequestMiddleware(performGetRequest);

    middleware = decorateMiddlewares(middleware, middlewares);

    request.method = 'GET';

    return middleware.fetch(request);
  }

  @nonVirtual
  Future<DPHttpResponse> post(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = PerformApiRequestMiddleware(performPostRequest);

    middleware = decorateMiddlewares(middleware, middlewares);

    request.method = 'POST';

    return middleware.fetch(request);
  }

  Future<DPHttpResponse> patch(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = PerformApiRequestMiddleware(performPatchRequest);

    middleware = decorateMiddlewares(middleware, middlewares);

    request.method = 'PATCH';

    return middleware.fetch(request);
  }

  Future<DPHttpResponse> put(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = PerformApiRequestMiddleware(performPutRequest);

    middleware = decorateMiddlewares(middleware, middlewares);

    request.method = 'PUT';

    return middleware.fetch(request);
  }

  Future<DPHttpResponse> delete(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) {
    ApiMiddleware middleware = PerformApiRequestMiddleware(performDeleteRequest);

    middleware = decorateMiddlewares(middleware, middlewares);

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
