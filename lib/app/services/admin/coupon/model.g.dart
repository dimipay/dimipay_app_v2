// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CouponImpl _$$CouponImplFromJson(Map<String, dynamic> json) => _$CouponImpl(
      code: json['code'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      expiresAt: json['expiresAt'] as String,
    );

Map<String, dynamic> _$$CouponImplToJson(_$CouponImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'expiresAt': instance.expiresAt,
    };

_$CouponTypeImpl _$$CouponTypeImplFromJson(Map<String, dynamic> json) =>
    _$CouponTypeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$CouponTypeImplToJson(_$CouponTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
    };
