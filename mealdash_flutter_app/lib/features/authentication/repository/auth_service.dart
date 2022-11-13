import 'package:dio/dio.dart';
import 'package:mealdash_app/features/authentication/dtos/user_login_dto.dart';
import 'package:mealdash_app/features/authentication/dtos/user_signup_dto.dart';
import 'package:mealdash_app/service_locator.dart';

class AuthService {
  final DioClient dioClient;

  const AuthService({required this.dioClient});

  Future<Response> signUp(UserSignUpDTO userSignUpDTO) async {
    final Response response = await dioClient.dio.post(
      '/signup',
      data: userSignUpDTO.toJson(),
    );
    return response;
  }

  Future<Response> login(UserLoginDTO userLoginDTO) async {
    final Response response = await dioClient.dio.post(
      '/login',
      data: userLoginDTO.toJson(),
    );
    return response;
  }

  Future<Response> logout() async {
    final String cookieHeader = (await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    ))
        .map((e) => e.toString())
        .join('; ');
    final Response response = await dioClient.dio.post(
      '/logout',
      options: Options(
        headers: {
          // 'Cookie': 'Authorization=sadfasdf', // LOGS OUT UNAUTHORIZED USER WHEN COOKIE IS INVALID AND RETURNS 401 UNAUTHORIZED
          'Cookie': cookieHeader,
        },
      ),
    );
    return response;
  }
}
