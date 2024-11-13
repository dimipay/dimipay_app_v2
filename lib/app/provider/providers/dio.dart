import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dimipay_app_v2/app/provider/api_provider.dart';
import 'package:dimipay_app_v2/app/provider/middleware.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dio/dio.dart';

class DioApiProvider extends ApiProvider {
  final Dio dio;

  DioApiProvider({required this.dio});

  @override
  Future<DPHttpResponse> performGetRequest(DPHttpRequest request) async {
    Response dioResponse = await dio.get(
      request.path,
      queryParameters: request.queryParameters,
      data: request.body,
      options: Options(headers: request.headers),
    );
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  @override
  Future<DPHttpResponse> performDeleteRequest(DPHttpRequest request) async {
    Response dioResponse = await dio.delete(
      request.path,
      queryParameters: request.queryParameters,
      data: request.body,
      options: Options(headers: request.headers),
    );
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  @override
  Future<DPHttpResponse> performPostRequest(DPHttpRequest request) async {
    Response dioResponse = await dio.post(
      request.path,
      queryParameters: request.queryParameters,
      data: request.body,
      options: Options(headers: request.headers),
    );
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  @override
  Future<DPHttpResponse> performPatchRequest(DPHttpRequest request) async {
    Response dioResponse = await dio.patch(
      request.path,
      queryParameters: request.queryParameters,
      data: request.body,
      options: Options(headers: request.headers),
    );
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  @override
  Future<DPHttpResponse> performPutRequest(DPHttpRequest request) async {
    Response dioResponse = await dio.put(
      request.path,
      queryParameters: request.queryParameters,
      data: request.body,
      options: Options(headers: request.headers),
    );
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<Stream<Map<String, dynamic>>> getStream(DPHttpRequest request, [List<ApiMiddleware> middlewares = const []]) async {
    ApiMiddleware middleware = decorateWithMiddlewares((request) async {
      request.headers["Accept"] = "text/event-stream";
      Response<ResponseBody> response = await dio.get(
        request.path,
        queryParameters: request.queryParameters,
        options: Options(
          headers: request.headers,
          responseType: ResponseType.stream,
        ),
      );
      return DPHttpResponse.fromDioStreamResponse(response);
    }, middlewares);

    DPHttpResponse response = await middleware.fetch(request);

    return (response.data as ResponseBody).stream.transform(
      StreamTransformer.fromHandlers(
        handleData: (Uint8List rawdata, sink) {
          String strData = String.fromCharCodes(rawdata);
          String formatedData = strData.substring(strData.indexOf('{'), strData.indexOf('}') + 1);
          Map<String, dynamic> data = json.decode(formatedData);

          sink.add(data);
        },
      ),
    );
  }
}
