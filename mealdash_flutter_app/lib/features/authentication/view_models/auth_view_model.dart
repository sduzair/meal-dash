import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';

import 'package:mealdash_app/features/authentication/repository/auth_service.dart';
import 'package:mealdash_app/service_locator.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthViewModel with ChangeNotifier, DiagnosticableTreeMixin {

  final AuthService authService;
  final SharedPreferences prefs;

  UserAuthViewModel({required this.prefs, required this.authService}) {
    _isLoggedIn = prefs.getBool(constants.loggedInKey) ?? false;
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  final UserSignUpModel _userSignUpModel = constants.isTestingSignUp
      ? UserSignUpModel.initializeDummyVals()
      : UserSignUpModel.empty();

  UserSignUpModel get userSignUpModel => _userSignUpModel;

  _setIsLoggedIn(bool value) async {
    _isLoggedIn = value;
    await prefs.setBool(constants.loggedInKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    _isLoggedIn = prefs.getBool(constants.loggedInKey) ?? false;
    notifyListeners();
  }

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  bool _isSigningUpError = false;
  bool get isSigningUpError => _isSigningUpError;

  String? _signUpErrorMessage;
  String? get signUpErrorMessage => _signUpErrorMessage;

  bool _isSigningUpSuccess = false;
  bool get isSigningUpSuccess => _isSigningUpSuccess;

  Future<void> signUp() async {
    print(_userSignUpModel.toJson());
    _isSigningUp = true;
    _isSigningUpError = false;
    _isSigningUpSuccess = false;
    notifyListeners();

    try {
      await authService.signUp(_userSignUpModel);
      _isSigningUpSuccess = true;
    } on DioError catch (e) {
      _isSigningUpError = true;
      _signUpErrorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      _isSigningUp = false;
      notifyListeners();
    }
  }

  final bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  final bool _isLoggingInErrorInvalidCredentials = false;
  bool get isLoggingInErrorInvalidCredentials =>
      _isLoggingInErrorInvalidCredentials;

  final bool _isLoggingInErrorUnknown = false;
  bool get isLoggingInErrorUnknown => _isLoggingInErrorUnknown;

  // bool _isLoggingInErrorTimeout = false;
  // bool get isLoggingInErrorTimeout => _isLoggingInErrorTimeout;

  // Future<void> signIn(UserLoginModel userLoginModel) async {
  //   print(userLoginModel.toJson());
  //   _isLoggingIn = true;
  //   _isLoggingInErrorInvalidCredentials = false;
  //   _isLoggingInErrorUnknown = false;
  //   // _isLoggingInErrorTimeout = false;
  //   notifyListeners();
  //   try {
  //     final response = await authService.login(userLoginModel);
  //     if (response.statusCode == 200) {
  //       _isLoggedIn = true;
  //       _setIsLoggedIn(true);
  //       return;
  //       // } else if (response.statusCode == 408) {
  //       //   _isLoggingInError = true;
  //       //   _isLoggingInErrorTimeout = true;
  //       //   return;
  //     } else {
  //       _isLoggingInErrorInvalidCredentials = true;
  //       return;
  //     }
  //   } catch (e) {
  //     _isLoggingInErrorUnknown = true;
  //     return;
  //   } finally {
  //     _isLoggingIn = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> loginTestUser() {
  //   final userLoginModel = UserLoginModel(
  //     email: 'test@sdf.com',
  //     password: '123456',
  //   );
  //   return signIn(userLoginModel);
  // }

  bool _isSigningOut = false;
  bool get isSigningOut => _isSigningOut;

  void setIsSigningOut(bool isSigningOut) {
    _isSigningOut = isSigningOut;
    notifyListeners();
  }

  void resetSignUp() {
    _isSigningUp = false;
    _isSigningUpError = false;
    _isSigningUpSuccess = false;
    _signUpErrorMessage = null;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isSigningUp',
        value: isSigningUp, ifTrue: 'Signing Up', ifFalse: 'Not Signing Up'));
    properties.add(FlagProperty('isLoggingIn',
        value: isLoggingIn, ifTrue: 'Signing In', ifFalse: 'Not Signing In'));
    properties.add(FlagProperty('isSigningOut',
        value: isSigningOut,
        ifTrue: 'Signing Out',
        ifFalse: 'Not Signing Out'));
  }
}
