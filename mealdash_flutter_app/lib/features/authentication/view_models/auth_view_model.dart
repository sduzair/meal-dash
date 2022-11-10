import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/authentication/models/user_login_model.dart';
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

  // LOGIN METHODS

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  _setIsLoggedInSharedPrefs(bool value) async {
    _isLoggedIn = value;
    await prefs.setBool(constants.loggedInKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    _isLoggedIn = prefs.getBool(constants.loggedInKey) ?? false;
    notifyListeners();
  }

  final UserLoginModel _userLoginModel = constants.isTestingLogin
      ? UserLoginModel.initializeDummyVals()
      : UserLoginModel.empty();

  UserLoginModel get userLoginModel => _userLoginModel;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  bool _isLoggingInError = false;
  bool get isLoggingInError => _isLoggingInError;

  String? _loginErrorMessage;
  String? get loginErrorMessage => _loginErrorMessage;

  bool _isLoggingInSuccess = false;
  bool get isLoggingInSuccess => _isLoggingInSuccess;

  bool _isShowLoggingInSuccessPopup = false;
  bool get isShowLoggingInSuccessPopup => _isShowLoggingInSuccessPopup;

  Future<void> login() async {
    print('login() called');
    print(_userLoginModel.toJson());
    resetLoginAndNotifyListeners();
    try {
      await authService.login(_userLoginModel);
      _isLoggingInSuccess = true;
      _isShowLoggingInSuccessPopup = true;
      _isLoggedIn = true;
      _setIsLoggedInSharedPrefs(true);
    } on DioError catch (e) {
      _isLoggingInError = true;
      _loginErrorMessage = DioExceptions.fromDioError(e).message;
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  void resetLoginAndNotifyListeners() {
    _isLoggingIn = false;
    _isLoggingInSuccess = false;
    _isLoggingInError = false;
    _loginErrorMessage = null;
    notifyListeners();
  }

  // TODO: WHEN DOCKER INITS DATABASE WITH TEST USER USE THIS TO TEST LOGIN
  // Future<void> loginTestUser() {
  //   final userLoginModel = UserLoginModel(
  //     email: 'test@sdf.com',
  //     password: '123456',
  //   );
  //   return signIn(userLoginModel);
  // }

  // SIGN UP METHODS
  final UserSignUpModel _userSignUpModel = constants.isTestingSignUp
      ? UserSignUpModel.initializeDummyVals()
      : UserSignUpModel.empty();

  UserSignUpModel get userSignUpModel => _userSignUpModel;

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  bool _isSigningUpError = false;
  bool get isSigningUpError => _isSigningUpError;

  String? _signUpErrorMessage;
  String? get signUpErrorMessage => _signUpErrorMessage;

  bool _isSigningUpSuccess = false;
  bool get isSigningUpSuccess => _isSigningUpSuccess;

  
  bool _isShowSignupSuccessPopup = false;
  bool get isShowSignupSuccessPopup => _isShowSignupSuccessPopup;

  Future<void> signUp() async {
    print('signUp() called');
    print(_userSignUpModel.toJson());
    resetSignUpAndNotifyListeners();

    try {
      await authService.signUp(_userSignUpModel);
      _isSigningUpSuccess = true;
      _isShowSignupSuccessPopup = true;
    } on DioError catch (e) {
      _isSigningUpError = true;
      _signUpErrorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      _isSigningUp = false;
      notifyListeners();
    }
  }

  void resetSignUpAndNotifyListeners() {
    _isSigningUp = false;
    _isSigningUpError = false;
    _isSigningUpSuccess = false;
    _signUpErrorMessage = null;
    notifyListeners();
  }

  // SIGNOUT METHODS

  bool _isSigningOut = false;
  bool get isSigningOut => _isSigningOut;

  void setIsSigningOut(bool isSigningOut) {
    _isSigningOut = isSigningOut;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isSigningUp',
        value: isSigningUp,
        ifTrue: 'Signing Up',
        ifFalse: 'Not Signing Up',
      ),
    );
    properties.add(FlagProperty('isLoggingIn',
        value: isLoggingIn,
        ifTrue: 'Signing In',
        ifFalse: 'Not Signing In',
      ),
    );
    properties.add(FlagProperty('isSigningOut',
        value: isSigningOut,
        ifTrue: 'Signing Out',
        ifFalse: 'Not Signing Out',
      ),
    );
  }
}
