class DPHttpRequest {
  String path;
  Map<String, dynamic> queryParameters;
  Map<String, Object?> headers;
  dynamic body;
  String? method;

  DPHttpRequest(
    this.path, {
    Map<String, dynamic>? queryParameters,
    Map<String, Object?>? headers,
    this.body,
    this.method,
  })  : queryParameters = queryParameters ?? {},
        headers = headers ?? {};
}
