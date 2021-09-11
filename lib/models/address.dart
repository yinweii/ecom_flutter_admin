import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class AddressModel {
  final String addressId;
  final String name;
  final String phoneNumber;
  final String hamletNumber;
  final String commune;
  final String district;
  final String city;

  AddressModel(
      {final this.addressId,
      final this.name,
      final this.phoneNumber,
      final this.hamletNumber,
      final this.commune,
      final this.district,
      final this.city});
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}
