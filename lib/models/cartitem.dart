import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cartitem.g.dart';

@JsonSerializable()
class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final int price;
  final int discount;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.quantity,
      @required this.price,
      @required this.discount});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
