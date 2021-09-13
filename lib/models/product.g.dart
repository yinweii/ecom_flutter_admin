// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    proId: json['proId'] as String,
    type: json['type'] as int,
    title: json['title'] as String,
    shortInfo: json['shortInfo'] as String,
    publishedDate: json['publishedDate'] == null
        ? null
        : DateTime.parse(json['publishedDate'] as String),
    thumbnailUrl: json['thumbnailUrl'] as String,
    longDescription: json['longDescription'] as String,
    status: json['status'] as String,
    price: json['price'] as int,
    discount: json['discount'] as int,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'proId': instance.proId,
      'type': instance.type,
      'title': instance.title,
      'shortInfo': instance.shortInfo,
      'publishedDate': instance.publishedDate?.toIso8601String(),
      'thumbnailUrl': instance.thumbnailUrl,
      'longDescription': instance.longDescription,
      'status': instance.status,
      'price': instance.price,
      'discount': instance.discount,
    };
