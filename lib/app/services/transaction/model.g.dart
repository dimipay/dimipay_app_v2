// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as String,
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      date: DateTime.parse(json['date'] as String),
      products:
          (json['products'] as List<dynamic>).map((e) => e as String).toList(),
      totalPrice: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'date': instance.date.toIso8601String(),
      'total': instance.totalPrice,
      'products': instance.products,
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.CONFIRMED: 'CONFIRMED',
  TransactionStatus.CANCELED: 'CANCELED',
  TransactionStatus.FAILED: 'FAILED',
};

TransactionDetail _$TransactionDetailFromJson(Map<String, dynamic> json) =>
    TransactionDetail(
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

Map<String, dynamic> _$TransactionDetailToJson(TransactionDetail instance) =>
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

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toInt(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'unitPrice': instance.unitPrice,
    };
