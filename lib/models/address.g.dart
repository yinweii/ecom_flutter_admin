// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    addressId: json['addressId'] as String,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    hamletNumber: json['hamletNumber'] as String,
    commune: json['commune'] as String,
    district: json['district'] as String,
    city: json['city'] as String,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'hamletNumber': instance.hamletNumber,
      'commune': instance.commune,
      'district': instance.district,
      'city': instance.city,
    };
