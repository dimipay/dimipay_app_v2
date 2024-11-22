import 'package:dimipay_app_v2/app/services/pay/local_pay/local_pay.dart';

Future<int> main() async {
  final LocalPay localPay = LocalPay(
    userIdentifier: '320fae03-9d72-4c19-816d-2c2d1d5b7ca2',
    deviceIdentifier: '265bed1a-9b4a-47fc-8765-b421d67a1458',
    authToken: 'adca79ec-7934-433c-acc0-a23088f39f58',
    rk: 'c0093def64d3b1880da182de861cec39',
  );

  String res = await localPay.generateLocalPayToken(
    paymentMethodIdentifier: 1,
    paymentMethodCreatedAt: 1705896544745,
    t: 1721089757738,
    nonce: '01934f0337777ac38dcb8066c646b7fb',
  );

  print(res);
  return 0;
}
