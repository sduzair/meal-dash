// ignore: depend_on_referenced_packages, unused_import
import 'package:json_annotation/json_annotation.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  // String? username;
  @JsonKey(name: 'user_email')
  String? email;
  @JsonKey(name: 'user_password')
  String? password;

  UserLoginModel({
    required this.email,
    required this.password,
  });

  UserLoginModel.initializeDummyVals()
      : email = 'captainuzair+mealdash1@gmail.com',
        // username = 'uzair',
        password = 'asdf';

  UserLoginModel.empty();

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}


// {
//   "user_email": "captainuzair+mealdash1@gmail.com",
//   "user_password": "asdf"
// }