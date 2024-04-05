import 'package:dio/dio.dart';

class DPHttpResponse {
  String code;
  String? message;
  int statusCode;
  String timeStamp;
  dynamic data;
  dynamic errors;
  DPHttpResponse({
    required this.code,
    this.message,
    required this.statusCode,
    required this.timeStamp,
    this.data,
    this.errors,
  });

  factory DPHttpResponse.fromDioResponse(Response dioResponse) => DPHttpResponse(
        code: dioResponse.data['code'],
        message: dioResponse.data['message'],
        statusCode: dioResponse.data['statusCode'],
        timeStamp: dioResponse.data['timestamp'],
        data: dioResponse.data['data'],
        errors: dioResponse.data['errors'],
      );
}
