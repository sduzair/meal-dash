// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyEmailDTO _$VerifyEmailDTOFromJson(Map<String, dynamic> json) =>
    VerifyEmailDTO(
      activationCode: json['user_activation_code'] as int,
    );

Map<String, dynamic> _$VerifyEmailDTOToJson(VerifyEmailDTO instance) =>
    <String, dynamic>{
      'user_activation_code': instance.activationCode,
    };
