// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpModel _$UserSignUpModelFromJson(Map<String, dynamic> json) =>
    UserSignUpModel(
      email: json['user_email'] as String?,
      password: json['user_password'] as String?,
      phoneNumber: json['phone'] as String?,
      addressLine1: json['address1'] as String?,
      addressLine2: json['address2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postal'] as String?,
    )
      ..username = json['user_login'] as String?
      ..userType = json['user_type'] as String;

Map<String, dynamic> _$UserSignUpModelToJson(UserSignUpModel instance) =>
    <String, dynamic>{
      'user_login': instance.username,
      'user_email': instance.email,
      'user_password': instance.password,
      'phone': instance.phoneNumber,
      'address1': instance.addressLine1,
      'address2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'postal': instance.postalCode,
      'user_type': instance.userType,
    };
