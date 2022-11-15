// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginDTO _$UserLoginDTOFromJson(Map<String, dynamic> json) => UserLoginDTO(
      email: json['user_email'] as String?,
      password: json['user_password'] as String?,
    );

Map<String, dynamic> _$UserLoginDTOToJson(UserLoginDTO instance) =>
    <String, dynamic>{
      'user_email': instance.email,
      'user_password': instance.password,
    };
