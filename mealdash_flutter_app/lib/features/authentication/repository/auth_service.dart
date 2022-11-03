import 'package:dio/dio.dart';
import 'package:mealdash_app/features/authentication/models/user_login_model.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';
import 'package:mealdash_app/service_locator.dart';

class AuthService {

  final DioClient dioClient;

  const AuthService({required this.dioClient});

  Future<Response> signUp(UserSignUpModel userSignUpModel) async {
    final Response response = await dioClient.dio.post(
      '/signup',
      data: userSignUpModel.toJson(),
    );
    return response;
  }

  Future<Response> login(UserLoginModel userLoginModel) async {
    final Response response = await dioClient.dio.post(
      '/login',
      data: userLoginModel.toJson(),
    );
    return response;
  }
}
