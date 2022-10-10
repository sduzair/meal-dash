import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class AuthService {
  static Future<http.Response> signUp(UserSignUpModel userSignUpModel) async {
    final response = await http.post(
      Uri.parse('${constants.apiUrl}/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userSignUpModel.toJson()),
    );
    return response;
  }
}
