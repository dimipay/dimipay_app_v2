import 'dart:typed_data';

import 'package:base45/base45.dart';
import 'package:dimipay_app_v2/app/services/pay/local_pay/local_pay.dart';

Future<int> main() async {
  final LocalPay localPay = LocalPay(
    userIdentifier: '320fae03-9d72-4c19-816d-2c2d1d5b7ca2',
    deviceIdentifier: '265bed1a-9b4a-47fc-8765-b421d67a1458',
    authToken: Uint8List.fromList([0xad, 0xca, 0x79, 0xec, 0x79, 0x34, 0x43, 0x3c, 0xac, 0xc0, 0xa2, 0x30, 0x88, 0xf3, 0x9f, 0x58]),
    rk: Uint8List.fromList([0xc0, 0x09, 0x3d, 0xef, 0x64, 0xd3, 0xb1, 0x88, 0x0d, 0xa1, 0x82, 0xde, 0x86, 0x1c, 0xec, 0x39]),
  );

  Uint8List res = await localPay.generateLocalPayToken(
    paymentMethodIdentifier: 1,
    t0: 1705896544745,
    t: 1721089757738,
    nonce: '01934f03-3777-7ac3-8dcb-8066c646b7fb',
    authType: AuthType.localAuth,
  );

  print(Base45.encode(res));
  return 0;
}
