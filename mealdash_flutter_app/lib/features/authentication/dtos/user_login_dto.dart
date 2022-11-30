// ignore: depend_on_referenced_packages, unused_import
import 'package:json_annotation/json_annotation.dart';

part 'user_login_dto.g.dart';

@JsonSerializable()
class UserLoginDTO {
  // String? username;
  @JsonKey(name: 'user_email')
  String? email;
  @JsonKey(name: 'user_password')
  String? password;

  UserLoginDTO({
    required this.email,
    required this.password,
  });

  UserLoginDTO.initializeDummyVals()
      : email = 'captasdf65sdfgsdfg4ddddddddddddsh123456@gmail.com',
        // username = 'uzair',
        password = 'asdf';

  UserLoginDTO.testUserLoginDTO()
      : email = "captasdf65sdfgsdfg4ddddddddddddsh123456@gmail.com",
        password = "asdf";

  UserLoginDTO.empty();

  factory UserLoginDTO.fromJson(Map<String, dynamic> json) =>
      _$UserLoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginDTOToJson(this);
}

// {
//   "user_email": "captainuzair+mealdash1@gmail.com",
//   "user_password": "asdf"
// }

/* 
Test User Credentials:
{
  "user_login": "test",
  "user_email": "asdsk@ldjf.com",
  "user_password": "asdf",
  "phone": "+12234567890",
  "user_type": "foodvendor",
  "address1": "asdf",
  "address2": "asdf",
  "city": "asdf",
  "state": "asdf",
  "postal": "A1A-1A1"
}
*/
