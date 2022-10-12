import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealdash_app/features/authentication/models/user_login_model.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class AuthService {
  static bool _isLoggedIn = false;
  static get isLoggedIn => _isLoggedIn;

  static Future<http.Response> signUp(UserSignUpModel userSignUpModel) async {
    final response = await http.post(
      Uri.parse('${constants.apiUrl}/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userSignUpModel.toJson()),
    );
    if (response.statusCode == 201) {
      _isLoggedIn = true;
    }
    return response;
  }

  static Future<http.Response> login(UserLoginModel userLoginModel) async {
    final response = await http.post(
      Uri.parse('${constants.apiUrl}/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userLoginModel.toJson()),
    );
    if (response.statusCode == 200) {
      _isLoggedIn = true;
    }
    return response;
  }
}
