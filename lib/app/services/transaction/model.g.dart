// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      unitCost: json['unitCost'] as int,
      count: json['count'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'unitCost': instance.unitCost,
      'count': instance.count,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      createdAt: DateTime.parse(json['createdAt'] as String),
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'products': instance.products,
      'totalPrice': instance.totalPrice,
    };
