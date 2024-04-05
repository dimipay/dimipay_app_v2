import 'dart:async';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dio/dio.dart';

abstract class ApiProvider {
  final Dio dio = Dio();
  Future<DPHttpResponse> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    Response dioResponse = await dio.get(path, queryParameters: queryParameters, options: options);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> delete(String path, {dynamic data}) async {
    Response dioResponse = await dio.delete(path, data: data);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    Response dioResponse = await dio.post(path, data: data, queryParameters: queryParameters, options: options);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> patch(String path, {dynamic data}) async {
    Response dioResponse = await dio.patch(path, data: data);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }

  Future<DPHttpResponse> put(String path, {dynamic data}) async {
    Response dioResponse = await dio.put(path, data: data);
    return DPHttpResponse.fromDioResponse(dioResponse);
  }
}
