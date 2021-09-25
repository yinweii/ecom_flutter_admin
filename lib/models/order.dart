import 'package:ecom_admin/models/cartitem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class OrderItem {
  final String id;
  final String addressId;
  final String orderBy;
  final double total;
  final DateTime datetime;
  final bool isSuccess;
  final List<CartItem> cartItem;

  OrderItem(
      {this.id,
      this.addressId,
      this.orderBy,
      this.total,
      this.datetime,
      this.isSuccess,
      this.cartItem});

  @override
  String toString() {
    return 'OrderItem{id: $id, addressId: $addressId, orderBy: $orderBy, total: $total, orderTime: $datetime, isSuccess: $isSuccess, cartItem: $cartItem}';
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
