// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_signup_dto.g.dart';

@JsonSerializable()
class UserSignUpDTO {
  @JsonKey(name: 'user_login')
  String? username;
  @JsonKey(name: 'user_email')
  String? email;
  @JsonKey(name: 'user_password')
  String? password;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'phone')
  String? phoneNumber;
  @JsonKey(name: 'user_type')
  String userType = 'foodvendor';
  @JsonKey(name: 'address1')
  String? addressLine1;
  @JsonKey(name: 'address2')
  String? addressLine2;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'state')
  String? state;
  @JsonKey(name: 'postal')
  String? postalCode;

  UserSignUpDTO({
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

  UserSignUpDTO.initializeDummyVals()
      : username = 'uzDasdfsdsfgsdddddddddfgFGHr1234567',
        email = 'captasdf65sdfgsdfg4ddddddddddddsh1234567@gmail.com',
        password = 'asdf',
        firstName = 'asdf',
        lastName = 'asdf',
        phoneNumber = '+12234567890',
        addressLine1 = 'asdf',
        addressLine2 = 'asdf',
        city = 'asdf',
        state = 'asdf',
        postalCode = 'A1A-1A1';

  UserSignUpDTO.empty();

  factory UserSignUpDTO.fromJson(Map<String, dynamic> json) =>
      _$UserSignUpDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserSignUpDTOToJson(this);
}
