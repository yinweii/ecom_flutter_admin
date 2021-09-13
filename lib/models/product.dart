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
      {@required this.proId,
      @required this.type,
      @required this.title,
      @required this.shortInfo,
      @required this.publishedDate,
      @required this.thumbnailUrl,
      @required this.longDescription,
      @required this.status,
      @required this.price,
      @required this.discount});
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
