import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    required String code,
    required String name,
    required int amount,
    required String expiresAt,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}

@freezed
class CouponType with _$CouponType {
  const factory CouponType({
    required String id,
    required String name,
    String? description,
    required int amount,
  }) = _CouponType;

  factory CouponType.fromJson(Map<String, dynamic> json) => _$CouponTypeFromJson(json);
}
