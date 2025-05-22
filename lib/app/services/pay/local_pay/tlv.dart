import 'dart:math' as math;
import 'dart:typed_data';

enum Tag {
  authType,
  authToken,
  userIdentifier,
  deviceIdentifier,
  paymentMethodIdentifier,
  nonce,
  payloadLengthIndicator,
  additionalData;

  int get resolve => (index + 1) & 0x0f;
}

class TLV {
  final Tag t;
  final Uint8List v;
  late final Uint8List bytes;

  TLV(this.t, this.v) {
    final l = binaryExponentOf(v);
    final tl = (t.resolve << 4) | l;
    bytes = Uint8List.fromList([tl] + v);
  }

  static int binaryExponentOf(Uint8List value) {
    double l = log2(value.length);
    if (l.isNaN || l.isInfinite || l < 0 || l > 5 || !isInt(l)) {
      throw Exception('v의 크기는 2의 제곱수이고 2^32 비트보다 작아야 합니다.');
    }
    return l.toInt();
  }

  static bool isInt(double x) {
    return x.remainder(1) == 0;
  }

  static double log2(num x) {
    return math.log(x) / math.log(2);
  }
}
