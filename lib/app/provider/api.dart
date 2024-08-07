import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/interceptors/jwt.dart';
import 'package:dimipay_app_v2/app/provider/interceptors/log.dart';

class ProdApiProvider extends ApiProvider {
  final baseUrl = 'https://prod-next.dimipay.io/';

  ProdApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class ProdSecureApiProvider extends SecureApiProvider {
  final baseUrl = 'https://prod-next.dimipay.io/';

  ProdSecureApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class DevApiProvider extends ApiProvider {
  final baseUrl = 'https://dev-next.dimipay.io';

  DevApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}

class DevSecureApiProvider extends SecureApiProvider {
  final baseUrl = 'https://dev-next.dimipay.io';

  DevSecureApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }
}
