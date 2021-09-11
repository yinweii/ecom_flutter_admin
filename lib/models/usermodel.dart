import 'package:json_annotation/json_annotation.dart';
part 'usermodel.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String email;
  final String name;

  UserModel({this.uid, this.email, this.name});
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
