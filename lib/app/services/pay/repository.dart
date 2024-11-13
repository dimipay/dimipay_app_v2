import 'dart:async';
import 'package:dimipay_app_v2/app/provider/middlewares/jwt.dart';
import 'package:dimipay_app_v2/app/provider/middlewares/pin.dart';
import 'package:dimipay_app_v2/app/provider/model/request.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/provider/providers/dio.dart';
import 'package:dimipay_app_v2/app/services/pay/model.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';

class PayRepository {
  final DioApiProvider api;

  PayRepository(this.api);

  Future<Stream<TransactionStatus>> getTransactionStatus() async {
    String url = "/transactions/status";
    Stream<Map<String, dynamic>> stream = await api.getStream(DPHttpRequest(url), [JWTMiddleware()]);
    return stream.map(
      (event) {
        switch (event['status']) {
          case 'PENDING':
            return TransactionStatus.PENDING;
          case 'ERROR':
            return TransactionStatus.ERROR;
          case 'CONFIRMED':
            return TransactionStatus.CONFIRMED;
          case 'CANCELED':
            return TransactionStatus.CANCELED;
          case 'FAILED':
            return TransactionStatus.FAILED;
          default:
            return TransactionStatus.PENDING;
        }
      },
    );
  }

  Future<Map> getPaymentToken({required PaymentMethod paymentMethod, String? pin, String? bioKey}) async {
    String url = '/pay/legacy/${paymentMethod.id}';
    DPHttpResponse response = await api.get(DPHttpRequest(url), [JWTMiddleware(), OTPMiddleware()]);
    return response.data;
  }
}
