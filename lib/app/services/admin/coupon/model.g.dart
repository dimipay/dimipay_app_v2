// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      code: json['code'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      expiresAt: json['expiresAt'] as String,
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'expiresAt': instance.expiresAt,
    };

CouponType _$CouponTypeFromJson(Map<String, dynamic> json) => CouponType(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$CouponTypeToJson(CouponType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
    };
