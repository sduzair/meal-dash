import 'package:dio/dio.dart';
import 'package:mealdash_app/features/authentication/dtos/user_login_dto.dart';
import 'package:mealdash_app/features/authentication/dtos/user_signup_dto.dart';
import 'package:mealdash_app/service_locator.dart';

class AuthService {
  final DioClient dioClient;

  const AuthService({required this.dioClient});

  Future<Response> signUp(UserSignUpDTO userSignUpDTO) async {
    // clear cookies in /login and /signup before signing up a new user to avoid cookie conflicts with previous users
    // directly may not exist if user is logging in for the first time throwing an error
    try {
      await dioClient.cookieJar.deleteAll();
    } catch (e) {
      print(e);
    }
    final Response response = await dioClient.dio.post(
      '/signup',
      data: userSignUpDTO.toJson(),
    );
    return response;
  }

  Future<Response> login(UserLoginDTO userLoginDTO) async {
    // clear cookies in /login and /signup before logging in a new user to avoid cookie conflicts with previous users
    // directly may not exist if user is logging in for the first time throwing an error
    try {
      await dioClient.cookieJar.deleteAll();
    } catch (e) {
      print(e);
    }

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

    // clear cookies in /login and /signup before logging out a user to avoid cookie conflicts with previous users
    await dioClient.cookieJar.deleteAll();

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
