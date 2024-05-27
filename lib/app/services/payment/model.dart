import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

// g.dart 파일 생성 : flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class PaymentMethod {
  String id;
  String name;
  String preview;
  String companyCode;
  PaymentMethod({required this.id, required this.name, required this.preview, required this.companyCode});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);

  String getLogoImagePath() {
    const url = 'assets/images/card_company_logo/';
    final companyCodeToImagePath = {
      '01': 'BC.svg',
      '02': 'Kb.svg',
      '03': 'Hana.svg',
      '04': 'Samsung.svg',
      '06': 'Shinhan.svg',
      '07': 'Hyundai.svg',
      '08': 'Lotte.svg',
      '11': 'Citi.svg',
      '12': 'NH.svg',
      '13': 'Suhyup.svg',
      '14': 'Shinhyup.svg',
      '15': 'Woori.svg',
      '16': 'Hana.svg',
      '21': 'KJB.svg',
      '25': 'VISA.svg',
      '26': 'Mastercard.svg',
      '32': 'Post.svg',
      '35': 'MG.svg',
      '36': 'KDB.svg',
      '37': 'Kakaobank.svg',
      '38': 'Kbank.svg',
      '40': 'Kakaobank.svg',
    };
    return url + (companyCodeToImagePath[companyCode] ?? 'Unknown.svg');
  }
}
