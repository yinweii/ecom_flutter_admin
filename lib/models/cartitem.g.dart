// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    id: json['id'] as String,
    title: json['title'] as String,
    imageUrl: json['imageUrl'] as String,
    quantity: json['quantity'] as int,
    price: json['price'] as int,
    discount: json['discount'] as int,
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'price': instance.price,
      'discount': instance.discount,
    };
