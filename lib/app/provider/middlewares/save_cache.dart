import 'dart:async';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/cache/service.dart';
import 'package:get/get.dart';

class SaveCache extends ApiMiddleware {
  @override
  ApiMiddleware copy() {
    return SaveCache();
  }

  @override
  Future<DPHttpResponse> handle(DPHttpRequest request, Future<DPHttpResponse> Function(DPHttpRequest) next) async {
    DPHttpResponse response = await next(request);

    HttpCacheService cacheService = Get.find<HttpCacheService>();
    await cacheService.save(request, response);

    return response;
  }
}
