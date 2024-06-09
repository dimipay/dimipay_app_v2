import 'dart:async';
import 'package:dimipay_app_v2/app/provider/api_interface.dart';
import 'package:dimipay_app_v2/app/provider/model/response.dart';
import 'package:dimipay_app_v2/app/services/pay/model.dart';
import 'package:dimipay_app_v2/app/services/payment/model.dart';
import 'package:get/get.dart';

class PayRepository {
  final SecureApiProvider api;

  PayRepository({SecureApiProvider? api}) : api = api ?? Get.find<SecureApiProvider>();

  Future<Stream<TransactionStatus>> getTransactionStatus() async {
    String url = "/transactions/status";
    Stream<Map<String, dynamic>> stream = await api.getStream(
      url,
    );
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
    DPHttpResponse response = await api.get(url, needPinOTP: true);
    return response.data;
  }
}
