import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

// g.dart 파일 생성 : dart run build_runner build

@JsonSerializable()
class Coupon {
  String code;
  String name;
  int amount;
  String expiresAt;

  Coupon({
    required this.code,
    required this.name,
    required this.amount,
    required this.expiresAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}

@JsonSerializable()
class CouponType {
  String id;
  String name;
  String? description;
  int amount;

  CouponType({
    required this.id,
    required this.name,
    this.description,
    required this.amount,
  });

  factory CouponType.fromJson(Map<String, dynamic> json) =>
      _$CouponTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CouponTypeToJson(this);
}
