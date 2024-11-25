import 'dart:typed_data';

import 'package:base45/base45.dart';
import 'package:dimipay_app_v2/app/services/pay/local_pay/local_pay.dart';

Future<int> main() async {
  final LocalPay localPay = LocalPay(
    userIdentifier: '320fae03-9d72-4c19-816d-2c2d1d5b7ca2',
    deviceIdentifier: '265bed1a-9b4a-47fc-8765-b421d67a1458',
    authToken: 'adca79ec-7934-433c-acc0-a23088f39f58',
    rk: Uint8List.fromList([0xc0, 0x09, 0x3d, 0xef, 0x64, 0xd3, 0xb1, 0x88, 0x0d, 0xa1, 0x82, 0xde, 0x86, 0x1c, 0xec, 0x39]),
  );

  Uint8List res = await localPay.generateLocalPayToken(
    paymentMethodIdentifier: 1,
    t0: 1705896544745,
    t: 1721089757738,
    nonce: '01934f03-3777-7ac3-8dcb-8066c646b7fb',
  );

  print(Base45.encode(res));
  return 0;
}
