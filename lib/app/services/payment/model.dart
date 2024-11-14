import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class PaymentMethod with _$PaymentMethod {
  const PaymentMethod._();

  const factory PaymentMethod({
    required String id,
    required String name,
    required String preview,
    required String cardCode,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

  String getLogoImagePath() {
    const url = 'assets/images/card_company_logo/';
    final companyCodeToImagePath = {
      'BC': 'BC.svg',
      'Kb': 'Kb.svg',
      'Hana': 'Hana.svg',
      'Samsung': 'Samsung.svg',
      'Shinhan': 'Shinhan.svg',
      'Hyundai': 'Hyundai.svg',
      'Lotte': 'Lotte.svg',
      'Citi': 'Citi.svg',
      'NH': 'NH.svg',
      'Suhyup': 'Suhyup.svg',
      'NACUFOK': 'Shinhyup.svg',
      'Woori': 'Woori.svg',
      'KJB': 'KJB.svg',
      'VISA': 'VISA.svg',
      'Mastercard': 'Mastercard.svg',
      'Post': 'Post.svg',
      'MG': 'MG.svg',
      'KDB': 'KDB.svg',
      'Kakaobank': 'Kakaobank.svg',
      'Kbank': 'Kbank.svg',
      'AMEX': 'AMEX.svg',
      'Unionpay': 'Unionpay.svg',
      'Tossbank': 'Tossbank.svg',
      'Naverpay': 'Naverpay.svg',
    };
    return url + (companyCodeToImagePath[cardCode] ?? 'Unknown.svg');
  }
}
