// ignore: depend_on_referenced_packages, unused_import
import 'package:json_annotation/json_annotation.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  String? username;
  String? email;
  String? password;

  UserLoginModel({
    required this.email,
    required this.password,
  });

  UserLoginModel.initializeDummyVals()
      : username = 'test',
        email = 'skaldjf@asdfklj.com',
        password = 'asdf';

  UserLoginModel.empty();

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}
