import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product with ChangeNotifier {
  final String proId;
  final int type;
  final String title;
  final String shortInfo;
  final DateTime publishedDate;
  final String thumbnailUrl;
  final String longDescription;
  final String status;
  final int price;
  final int discount;

  Product(
      {this.proId,
      this.type,
      this.title,
      this.shortInfo,
      this.publishedDate,
      this.thumbnailUrl,
      this.longDescription,
      this.status,
      this.price,
      this.discount});

  Product copyWith({
    String proId,
    int type,
    String title,
    String shortInfo,
    DateTime publishedDate,
    String thumbnailUrl,
    String longDescription,
    String status,
    int price,
    int discount,
  }) {
    return Product(
      proId: proId ?? this.proId,
      type: type ?? this.type,
      title: title ?? this.title,
      shortInfo: shortInfo ?? this.shortInfo,
      publishedDate: publishedDate ?? publishedDate,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      longDescription: longDescription ?? this.longDescription,
      status: status ?? this.status,
      price: price ?? this.price,
      discount: discount ?? this.discount,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
  @override
  String toString() {
    return 'Product{proId: $proId, type: $type, title: $title, shortInfo: $shortInfo, publishedDate: $publishedDate, thumbnailUrl: $thumbnailUrl, longDescription: $longDescription, status: $status, price: $price, discount: $discount}';
  }
}
