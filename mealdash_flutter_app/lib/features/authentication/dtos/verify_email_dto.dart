// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'verify_email_dto.g.dart';

@JsonSerializable()
class VerifyEmailDTO {
  @JsonKey(name: 'user_activation_code')
  int activationCode = 0;

  VerifyEmailDTO({
    required this.activationCode,
  });

  VerifyEmailDTO.initializeDummyVals() : activationCode = 676991;

  VerifyEmailDTO.empty();

  factory VerifyEmailDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailDTOToJson(this);
}
