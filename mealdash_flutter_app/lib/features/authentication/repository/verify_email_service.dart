import 'package:dio/dio.dart';
import 'package:mealdash_app/service_locator.dart';

class VerifyEmailService {
  final DioClient dioClient;

  const VerifyEmailService({required this.dioClient});

  Future<Response> verifyEmail(String email) async {
    final Response response = await dioClient.dio.post(
      '/verify-email',
      data: {'email': email},
    );
    return response;
  }
}
