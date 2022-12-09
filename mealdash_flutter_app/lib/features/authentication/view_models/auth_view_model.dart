import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/authentication/dtos/user_login_dto.dart';
import 'package:mealdash_app/features/authentication/dtos/user_signup_dto.dart';

import 'package:mealdash_app/features/authentication/repository/auth_service.dart';
import 'package:mealdash_app/service_locator.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final AuthService authService;
  final SharedPreferences prefs;

  UserAuthViewModel({
    required this.prefs,
    required this.authService,
    required this.isLoggedIn,
  })
      : _userLoginDTO = constants.isTestingLogin
            ? UserLoginDTO.initializeDummyVals()
            : UserLoginDTO.empty(),
        _userSignUpDTO = constants.isTestingSignUp
            ? UserSignUpDTO.initializeDummyVals()
            : UserSignUpDTO.empty();

  //  LOGIN TEST USER
  Future<void> loginTestUser() async {
    print('loginTestUser() called');
    try {
      await authService.login(UserLoginDTO.testUserLoginDTO());
      isLoggedIn = true;
      notifyListeners();
      _setIsLoggedInStateInSharedPrefsAsync(true);
    } on DioError catch (e) {
      print('Test user login failed: ${e.message}');
    }
  }

  bool isLoggedIn = false;

  Future<void> _setIsLoggedInStateInSharedPrefsAsync(bool value) async {
    isLoggedIn = value;
    await prefs.setBool(constants.loggedinKey, value);
  }

  // void checkLoggedInStateInSharedPrefsAndNotifyListeners() {
  //   isLoggedIn = prefs.getBool(constants.loggedinKey) ?? false;
  //   print('checkLoggedIn() called. isLoggedIn: $isLoggedIn');
  //   notifyListeners();
  // }

  // USER LOGIN METHODS

  final UserLoginDTO _userLoginDTO;

  UserLoginDTO get userLoginDTO => _userLoginDTO;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  bool _isLoggingInError = false;
  bool get isLoggingInError => _isLoggingInError;

  bool _isLoggingInErrorUnverifiedEmail = false;
  bool get isLoggingInErrorUnverifiedEmail => _isLoggingInErrorUnverifiedEmail;

  String? _loginErrorMessage;
  String? get loginErrorMessage => _loginErrorMessage;

  bool _isLoggingInSuccess = false;
  bool get isLoggingInSuccess => _isLoggingInSuccess;

  bool _showLoggingInSuccessPopup = false;
  bool get showLoggingInSuccessPopup => _showLoggingInSuccessPopup;

  Future<void> login() async {
    print('login() called');
    print(_userLoginDTO.toJson());
    resetLoginState();
    _isLoggingIn = true;
    notifyListeners();
    try {
      await authService.login(_userLoginDTO);
      _isLoggingInSuccess = true;
      _showLoggingInSuccessPopup = true;
      isLoggedIn = true;
      _setIsLoggedInStateInSharedPrefsAsync(true);
    } on DioError catch (e) {
      _isLoggingInError = true;
      _loginErrorMessage = DioExceptions.fromDioError(e).message;
      switch (DioExceptions.fromDioError(e).statusCode) {
        case 403:
          _isLoggingInErrorUnverifiedEmail = true;
          break;
      }
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  void resetLoginStateAndNotifyListeners() {
    _isLoggingIn = false;
    _isLoggingInSuccess = false;
    _isLoggingInError = false;
    _isLoggingInErrorUnverifiedEmail = false;
    _loginErrorMessage = null;
    _showLoggingInSuccessPopup = false;
    notifyListeners();
  }

  void resetLoginState() {
    _isLoggingIn = false;
    _isLoggingInSuccess = false;
    _isLoggingInError = false;
    _isLoggingInErrorUnverifiedEmail = false;
    _loginErrorMessage = null;
    _showLoggingInSuccessPopup = false;
  }

  // USER SIGN UP METHODS

  final UserSignUpDTO _userSignUpDTO;

  UserSignUpDTO get userSignUpDTO => _userSignUpDTO;

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  bool _isSigningUpError = false;
  bool get isSigningUpError => _isSigningUpError;

  bool _isSigningUpErrorUserAlreadyExists = false;
  bool get isSigningUpErrorUserAlreadyExists =>
      _isSigningUpErrorUserAlreadyExists;

  String? _signUpErrorMessage;
  String? get signUpErrorMessage => _signUpErrorMessage;

  bool _isSigningUpSuccess = false;
  bool get isSigningUpSuccess => _isSigningUpSuccess;

  bool _showSignupSuccessPopup = false;
  bool get showSignupSuccessPopup => _showSignupSuccessPopup;

  Future<void> signUp() async {
    print('signUp() called');
    print(_userSignUpDTO.toJson());
    resetSignUpState();
    _isSigningUp = true;
    notifyListeners();
    try {
      await authService.signUp(_userSignUpDTO);
      _isSigningUpSuccess = true;
      //* SIGNUP SUCCESSFUL AFTER VERIFICATION
      _showSignupSuccessPopup = false;
    } on DioError catch (e) {
      _isSigningUpError = true;
      _signUpErrorMessage = DioExceptions.fromDioError(e).message;
      switch (DioExceptions.fromDioError(e).statusCode) {
        case 409:
          _isSigningUpErrorUserAlreadyExists = true;
          break;
      }
    } finally {
      _isSigningUp = false;
      notifyListeners();
    }
  }

  void resetSignUpStateAndNotifyListeners() {
    _isSigningUp = false;
    _isSigningUpError = false;
    _isSigningUpErrorUserAlreadyExists = false;
    _isSigningUpSuccess = false;
    _signUpErrorMessage = null;
    _showSignupSuccessPopup = false;
    notifyListeners();
  }

  void resetSignUpState() {
    _isSigningUp = false;
    _isSigningUpError = false;
    _isSigningUpErrorUserAlreadyExists = false;
    _isSigningUpSuccess = false;
    _signUpErrorMessage = null;
    _showSignupSuccessPopup = false;
  }

  // LOGOUT METHODS

  bool _isLoggingOut = false;
  bool get isLoggingOut => _isLoggingOut;

  bool _isLoggingOutError = false;
  bool get isLoggingOutError => _isLoggingOutError;

  String? _logoutErrorMessage;
  String? get logoutErrorMessage => _logoutErrorMessage;

  bool _isLoggingOutSuccess = false;
  bool get isLoggingOutSuccess => _isLoggingOutSuccess;

  bool _showLoggingOutSuccessPopup = false;
  bool get showLoggingOutSuccessPopup => _showLoggingOutSuccessPopup;

  Future<void> logout() async {
    print('logout() called');
    resetLogoutState();
    _isLoggingOut = true;
    notifyListeners();
    try {
      await authService.logout();
      _isLoggingOutSuccess = true;
      _showLoggingOutSuccessPopup = true;
      isLoggedIn = false;
      _setIsLoggedInStateInSharedPrefsAsync(false);
    } on DioError catch (e) {
      _isLoggingOutError = true;
      _logoutErrorMessage = DioExceptions.fromDioError(e).message;
    } finally {
      _isLoggingOut = false;
      notifyListeners();
    }
  }

  void resetLogoutStateAndNotifyListeners() {
    _isLoggingOut = false;
    _isLoggingOutError = false;
    _isLoggingOutSuccess = false;
    _logoutErrorMessage = null;
    _showLoggingOutSuccessPopup = false;
    notifyListeners();
  }

  void resetLogoutState() {
    _isLoggingOut = false;
    _isLoggingOutError = false;
    _isLoggingOutSuccess = false;
    _logoutErrorMessage = null;
    _showLoggingOutSuccessPopup = false;
  }

  Future<void> logoutUnauthorizedAndNotifyListeners() async {
    _setIsLoggedInStateInSharedPrefsAsync(false);
    isLoggedIn = false;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'isSigningUp',
        value: isSigningUp,
        ifTrue: 'Signing Up',
        ifFalse: 'Not Signing Up',
      ),
    );
    properties.add(
      FlagProperty(
        'isLoggingIn',
        value: isLoggingIn,
        ifTrue: 'Signing In',
        ifFalse: 'Not Signing In',
      ),
    );
    properties.add(
      FlagProperty(
        'isLoggingOut',
        value: isLoggingOut,
        ifTrue: 'Logging Out',
        ifFalse: 'Not Logging Out',
      ),
    );
  }
}
