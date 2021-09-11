import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
class Customer {
  final String uid;
  final String name;
  final String email;

  Customer({this.uid, this.name, this.email});
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
