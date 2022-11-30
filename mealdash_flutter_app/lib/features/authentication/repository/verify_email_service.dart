import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mealdash_app/features/authentication/dtos/verify_email_dto.dart';
import 'package:mealdash_app/service_locator.dart';

class VerifyEmailService {
  final DioClient dioClient;

  const VerifyEmailService({required this.dioClient});

  Future<Response> verifyEmail(VerifyEmailDTO verifyEmailDTO) async {
    // TODO: 1. WHEN UNVERIFIED USER TRIES LOGGING IN EMPTY SIGNUP COOKIE
    // TODO: 2. WHEN UNVERIFIED USER TRIES SIGNING UP EMPTY LOGIN COOKIE
    // TODO: 3. WHEN UNVERIFIED USER TRIES VERIFYING EMAIL USE NON EMPTY COOKIE (SIGNUP OR LOGIN)
    var cookiesLogin = await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    );
    debugPrint('cookiesLogin: $cookiesLogin');

    var cookiesSignup = await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/signup'),
    );
    debugPrint('cookiesSignup: $cookiesSignup');

    if (cookiesLogin.isEmpty && cookiesSignup.isEmpty) {
      debugPrint('cookiesLogin.isEmpty && cookiesSignup.isEmpty');
      return Future.error('cookiesLogin.isEmpty && cookiesSignup.isEmpty');
    }

    var cookies = cookiesLogin.isNotEmpty ? cookiesLogin : cookiesSignup;

    final String cookieHeader = (cookies).map((e) => e.toString()).join('; ');
    final Response response = await dioClient.dio.put(
      '/verify-user',
      data: verifyEmailDTO.toJson(),
      options: Options(
        headers: {
          'Cookie': cookieHeader,
        },
      ),
    );
    // simulate network delay for testing purposes
    return response;
  }
}
