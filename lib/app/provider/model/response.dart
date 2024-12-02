class DPHttpResponse {
  String requredId;
  String code;
  String? message;
  int statusCode;
  String timeStamp;
  dynamic data;
  dynamic errors;
  DPHttpResponse({
    required this.requredId,
    required this.code,
    this.message,
    required this.statusCode,
    required this.timeStamp,
    this.data,
    this.errors,
  });
}
