import 'package:dio/dio.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';
import 'package:mealdash_app/service_locator.dart';

class AuthService {
  // static bool _isLoggedIn = false;
  // static get isLoggedIn => _isLoggedIn;

  // static Future<http.Response> signUp(UserSignUpModel userSignUpModel) async {
  //   final response = await http.post(
  //     Uri.parse('${constants.apiUrl}:${constants.apiPort}/signup'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(userSignUpModel.toJson()),
  //   );
  //   if (response.statusCode == 201) {
  //     // _isLoggedIn = true;
  //   }
  //   return response;
  // }

  final DioClient dioClient;

  const AuthService({required this.dioClient});

  // post request to sign up '${constants.apiUrl}:${constants.apiPort}/signup' using userSignUpModel as body and return response from server
  Future<Response> signUp(UserSignUpModel userSignUpModel) async {
    final Response response = await dioClient.dio.post(
      '/signup',
      data: userSignUpModel.toJson(),
    );
    return response;
  }
  



  // static Future<http.Response> login(UserLoginModel userLoginModel) async {
  //   final response = await http.post(
  //     Uri.parse('${constants.apiUrl}/loginsdf'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(userLoginModel.toJson()),
  //   );
  //   if (response.statusCode == 200) {
  //     // _isLoggedIn = true;
  //   }
  //   // response.headers.forEach((key, value) {
  //   //   print('$key: $value');
  //   // });
  //   return response;
  // }
}
