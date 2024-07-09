// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

enum TransactionStatus {
  @JsonValue('CONFIRMED')
  CONFIRMED,
  @JsonValue('CANCELED')
  CANCELED,
  @JsonValue('FAILED')
  FAILED,
}

enum TransactionType {
  @JsonValue('APP_QR')
  APP_QR,
  @JsonValue('FACESIGN')
  FACESIGN,
}

enum PurchaseType {
  @JsonValue('COUPON')
  COUPON,
  @JsonValue('GENERAL')
  GENERAL,
}

@JsonSerializable()
class Transaction {
  final String id;

  final TransactionStatus status;

  final DateTime date;

  @JsonKey(name: 'total')
  final int totalPrice;

  final List<String> products;
  Transaction({
    required this.id,
    required this.status,
    required this.date,
    required this.products,
    required this.totalPrice,
  });

  DateTime get localDate => date.toLocal();

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class TransactionDetail {
  final String id;
  final int totalPrice;
  final DateTime date;
  final TransactionStatus status;
  final String message;

  @JsonKey(name: 'type')
  final TransactionType transactionType;

  final PurchaseType purchaseType;

  final String? cardName;

  final List<Product> products;

  TransactionDetail({
    required this.id,
    required this.totalPrice,
    required this.date,
    required this.status,
    required this.message,
    required this.transactionType,
    required this.purchaseType,
    required this.cardName,
    required this.products,
  });

  DateTime get localDate => date.toLocal();

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => _$TransactionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDetailToJson(this);
}

@JsonSerializable()
class Product {
  final String name;
  final int amount;
  final int unitPrice;

  Product({required this.name, required this.amount, required this.unitPrice});
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  int get totalPrice => amount * unitPrice;
}
