import 'package:cookie_jar/cookie_jar.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/main.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal();

  late final Dio dio;

  late final CookieJar cookieJar;

  Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    cookieJar =
        PersistCookieJar(storage: FileStorage('${appDocDir.path}/.cookies/'));
    // TESTING ENVIRONMENT
    constants.clearCookies ? cookieJar.deleteAll() : null;
    // print the cookies to the console for debugging purposes only (not for production)
    printCookiesInPersistentCookieJarToConsole();

    // final cookieJar = CookieJar();
    dio = Dio()
      ..interceptors.add(CookieManager(cookieJar))
      ..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      )
      ..interceptors.add(
        // interceptor to intercept 401 errors and redirect to login page
        InterceptorsWrapper(
          onError: (DioError e, handler) {
            if (e.response?.statusCode == 401) {
              // redirect to login page
              print('401 error intercepted');
              // getit UserauthViewModel and logout user shared prefs
              getIt<UserAuthViewModel>().logoutUnauthorizedAndNotifyListeners();
            } else if (e.response?.statusCode == 403) {
              // redirect to login page
              print('403 error intercepted');
              // getit UserauthViewModel and logout user shared prefs
              getIt<UserAuthViewModel>().logoutUnauthorizedAndNotifyListeners();
            }
            return handler.next(e);
          },
        ),
      )
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json;
  }

  void printCookiesInPersistentCookieJarToConsole() {
    print('cookies in persistent cookie jar:');
    cookieJar.loadForRequest(Uri.parse('${Endpoints.baseUrl}/login')).then(
      (cookies) {
        print('cookies /login:');
        print(cookies.toString());
      },
    );
    cookieJar.loadForRequest(Uri.parse('${Endpoints.baseUrl}/signup')).then(
      (cookies) {
        print('cookies /signup:');
        print(cookies.toString());
      },
    );
    cookieJar
        .loadForRequest(Uri.parse('${Endpoints.baseUrl}/verify-user'))
        .then(
      (cookies) {
        print('cookies /verify-user:');
        print(cookies.toString());
      },
    );
  }
}

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = constants.apiBaseUrl;

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}

class DioExceptions implements Exception {
  late String message;

  /// status code exists only when exception is raised by server response
  int? statusCode;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        statusCode = dioError.response?.statusCode;
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'] ?? 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return error['message'] ?? 'Forbidden'; // LOGIN PAGE: UNVERIFIED EMAIL
      case 404:
        return error['message'] ?? 'Not found';
      case 409:
        return error['message'] ??
            'Conflict'; // LOIGN PAGE: INCORRECT PASSWORD OR EMAIL NOT FOUND
      case 500:
        return error['message'] ?? 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
