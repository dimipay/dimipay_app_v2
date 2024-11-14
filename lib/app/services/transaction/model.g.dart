// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      date: DateTime.parse(json['date'] as String),
      products:
          (json['products'] as List<dynamic>).map((e) => e as String).toList(),
      totalPrice: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'date': instance.date.toIso8601String(),
      'products': instance.products,
      'total': instance.totalPrice,
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.CONFIRMED: 'CONFIRMED',
  TransactionStatus.CANCELED: 'CANCELED',
  TransactionStatus.FAILED: 'FAILED',
};

_$TransactionDetailImpl _$$TransactionDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionDetailImpl(
      id: json['id'] as String,
      totalPrice: (json['totalPrice'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      message: json['message'] as String,
      transactionType:
          $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']),
      purchaseType: $enumDecode(_$PurchaseTypeEnumMap, json['purchaseType']),
      cardName: json['cardName'] as String?,
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TransactionDetailImplToJson(
        _$TransactionDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'date': instance.date.toIso8601String(),
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'message': instance.message,
      'type': _$TransactionTypeEnumMap[instance.transactionType],
      'purchaseType': _$PurchaseTypeEnumMap[instance.purchaseType]!,
      'cardName': instance.cardName,
      'products': instance.products,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.APP_QR: 'APP_QR',
  TransactionType.FACESIGN: 'FACESIGN',
};

const _$PurchaseTypeEnumMap = {
  PurchaseType.COUPON: 'COUPON',
  PurchaseType.GENERAL: 'GENERAL',
};

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toInt(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unitPrice': instance.unitPrice,
    };
