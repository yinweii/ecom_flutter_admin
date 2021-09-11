import 'package:ecom_admin/models/cartitem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class OrderItem {
  final String id;
  final String addressId;
  final String orderBy;
  final double total;
  final DateTime orderTime;
  final bool isSuccess;
  final List<CartItem> cartItem;

  OrderItem(
      {this.id,
      this.addressId,
      this.orderBy,
      this.total,
      this.orderTime,
      this.isSuccess,
      this.cartItem});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
