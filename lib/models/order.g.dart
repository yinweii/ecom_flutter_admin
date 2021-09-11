// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    id: json['id'] as String,
    addressId: json['addressId'] as String,
    orderBy: json['orderBy'] as String,
    total: (json['total'] as num)?.toDouble(),
    orderTime: json['orderTime'] == null
        ? null
        : DateTime.parse(json['orderTime'] as String),
    isSuccess: json['isSuccess'] as bool,
    cartItem: (json['cartItem'] as List)
        ?.map((e) =>
            e == null ? null : CartItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'addressId': instance.addressId,
      'orderBy': instance.orderBy,
      'total': instance.total,
      'orderTime': instance.orderTime?.toIso8601String(),
      'isSuccess': instance.isSuccess,
      'cartItem': instance.cartItem,
    };
