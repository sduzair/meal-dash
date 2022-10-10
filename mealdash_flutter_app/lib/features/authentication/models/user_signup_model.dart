import 'package:json_annotation/json_annotation.dart';

part 'user_signup_model.g.dart';

@JsonSerializable()
class UserSignUpModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String postalCode;

  UserSignUpModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) =>
      _$UserSignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSignUpModelToJson(this);
}
