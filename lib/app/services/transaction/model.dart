// ignore_for_file: constant_identifier_names, invalid_annotation_target
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required TransactionStatus status,
    required DateTime date,
    required List<String> products,
    @JsonKey(name: 'total') required int totalPrice,
  }) = _Transaction;

  DateTime get localDate => date.toLocal();

  const Transaction._();

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}

@freezed
class TransactionDetail with _$TransactionDetail {
  const factory TransactionDetail({
    required String id,
    required int totalPrice,
    required DateTime date,
    required TransactionStatus status,
    required String message,
    @JsonKey(name: 'type') TransactionType? transactionType,
    required PurchaseType purchaseType,
    required String? cardName,
    required List<Product> products,
  }) = _TransactionDetail;

  DateTime get localDate => date.toLocal();

  const TransactionDetail._();

  factory TransactionDetail.fromJson(Map<String, dynamic> json) => _$TransactionDetailFromJson(json);
}

@freezed
class Product with _$Product {
  const factory Product({
    required String name,
    required int amount,
    required int unitPrice,
  }) = _Product;

  int get totalPrice => amount * unitPrice;

  const Product._();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

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
