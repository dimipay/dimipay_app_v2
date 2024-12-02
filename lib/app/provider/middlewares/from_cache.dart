import 'dart:async';
import 'dart:convert';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:get/get.dart';

class FromCache extends ApiMiddleware {
  @override
  ApiMiddleware copy() {
    return FromCache();
  }

  @override
  DPHttpResponse handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) {
    HttpCacheService cacheService = Get.find<HttpCacheService>();
    String cachedData = cacheService.get(request);
    Map mapData = json.decode(cachedData);
    return DPHttpResponse(requredId: '', code: '304', statusCode: 304, timeStamp: '', data: mapData);
  }
}
