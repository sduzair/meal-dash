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

  UserAuthViewModel({required this.prefs, required this.authService})
      : _userLoginDTO = constants.isTestingLogin
            ? UserLoginDTO.initializeDummyVals()
            : UserLoginDTO.empty(),
        _userSignUpDTO = constants.isTestingSignUp
            ? UserSignUpDTO.initializeDummyVals()
            : UserSignUpDTO.empty() {
    _isLoggedIn = prefs.getBool(constants.loggedinKey) ?? false;
  }

  //  LOGIN TEST USER
  Future<void> loginTestUser() async {
    print('loginTestUser() called');
    try {
      await authService.login(UserLoginDTO.testUserLoginDTO());
      _isLoggedIn = true;
      notifyListeners();
      _setIsLoggedinSharedPrefsAndNotifyListeners(true);
    } on DioError catch (e) {
      print('Test user login failed: ${e.message}');
    }
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> _setIsLoggedinSharedPrefsAndNotifyListeners(bool value) async {
    _isLoggedIn = value;
    await prefs.setBool(constants.loggedinKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    _isLoggedIn = prefs.getBool(constants.loggedinKey) ?? false;
    notifyListeners();
  }

  // USER LOGIN METHODS

  final UserLoginDTO _userLoginDTO;

  UserLoginDTO get userLoginDTO => _userLoginDTO;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  bool _isLoggingInError = false;
  bool get isLoggingInError => _isLoggingInError;

  String? _loginErrorMessage;
  String? get loginErrorMessage => _loginErrorMessage;

  bool _isLoggingInSuccess = false;
  bool get isLoggingInSuccess => _isLoggingInSuccess;

  bool _showLoggingInSuccessPopup = false;
  bool get showLoggingInSuccessPopup => _showLoggingInSuccessPopup;

  Future<void> login() async {
    print('login() called');
    print(_userLoginDTO.toJson());
    resetLoginStateAndNotifyListeners();
    _isLoggingIn = true;
    notifyListeners();
    try {
      await authService.login(_userLoginDTO);
      _isLoggingInSuccess = true;
      _showLoggingInSuccessPopup = true;
      _isLoggedIn = true;
      await _setIsLoggedinSharedPrefsAndNotifyListeners(true);
    } on DioError catch (e) {
      _isLoggingInError = true;
      _loginErrorMessage = DioExceptions.fromDioError(e).message;
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  void resetLoginStateAndNotifyListeners() {
    _isLoggingIn = false;
    _isLoggingInSuccess = false;
    _isLoggingInError = false;
    _loginErrorMessage = null;
    _showLoggingInSuccessPopup = false;
    notifyListeners();
  }

  void resetLoginStateAndDontNotifyListeners() {
    _isLoggingIn = false;
    _isLoggingInSuccess = false;
    _isLoggingInError = false;
    _loginErrorMessage = null;
    _showLoggingInSuccessPopup = false;
  }

  // USER SIGN UP METHODS

  final UserSignUpDTO _userSignUpDTO;

  UserSignUpDTO get userSignUpModel => _userSignUpDTO;

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  bool _isSigningUpError = false;
  bool get isSigningUpError => _isSigningUpError;

  String? _signUpErrorMessage;
  String? get signUpErrorMessage => _signUpErrorMessage;

  bool _isSigningUpSuccess = false;
  bool get isSigningUpSuccess => _isSigningUpSuccess;

  bool _showSignupSuccessPopup = false;
  bool get showSignupSuccessPopup => _showSignupSuccessPopup;

  Future<void> signUp() async {
    print('signUp() called');
    print(_userSignUpDTO.toJson());
    resetSignUpStateAndNotifyListeners();
    _isSigningUp = true;
    notifyListeners();
    try {
      await authService.signUp(_userSignUpDTO);
      _isSigningUpSuccess = true;
      _showSignupSuccessPopup = true;
    } on DioError catch (e) {
      _isSigningUpError = true;
      _signUpErrorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      _isSigningUp = false;
      notifyListeners();
    }
  }

  void resetSignUpStateAndNotifyListeners() {
    _isSigningUp = false;
    _isSigningUpError = false;
    _isSigningUpSuccess = false;
    _signUpErrorMessage = null;
    _showSignupSuccessPopup = false;
    notifyListeners();
  }

  void resetSignUpState() {
    _isSigningUp = false;
    _isSigningUpError = false;
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
    resetLogoutStateAndNotifyListeners();
    _isLoggingOut = true;
    notifyListeners();
    try {
      await authService.logout();
      _isLoggingOutSuccess = true;
      _showLoggingOutSuccessPopup = true;
      _isLoggedIn = false;
      await _setIsLoggedinSharedPrefsAndNotifyListeners(false);
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

  Future<void> logoutUnauthorized() async {
    _isLoggedIn = false;
    await _setIsLoggedinSharedPrefsAndNotifyListeners(false);
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
