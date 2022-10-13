// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginModel _$UserLoginModelFromJson(Map<String, dynamic> json) =>
    UserLoginModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    )..username = json['username'] as String?;

Map<String, dynamic> _$UserLoginModelToJson(UserLoginModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
