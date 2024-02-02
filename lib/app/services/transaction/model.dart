import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class Product {
  String name;
  int unitCost;
  int count;

  Product({required this.name, required this.unitCost, required this.count});
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Transaction {
  DateTime createdAt;

  List<Product> products;
  int totalPrice;
  Transaction({
    required this.createdAt,
    required this.products,
    required this.totalPrice,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
