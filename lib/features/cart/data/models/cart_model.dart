import 'package:json_annotation/json_annotation.dart';
import 'package:market_app/features/cart/data/models/cart_item_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final List<CartItemModel> items;

  CartModel({required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
