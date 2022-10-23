import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/authentication/models/user_login_model.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';

import 'package:mealdash_app/features/authentication/repository/auth_service.dart';
import 'package:mealdash_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final SharedPreferences prefs;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  UserAuthViewModel(this.prefs) {
    _isLoggedIn = prefs.getBool(loggedInKey) ?? false;
  }

  _setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    prefs.setBool(loggedInKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    _isLoggedIn = prefs.getBool(loggedInKey) ?? false;
  }

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  bool _isSigningUpError = false;
  bool get isSigningUpError => _isSigningUpError;

  bool _isSigningUpSuccess = false;
  bool get isSigningUpSuccess => _isSigningUpSuccess;

  Future<void> signUp(UserSignUpModel userSignUpModel) async {
    print(userSignUpModel.toJson());
    _isSigningUp = true;
    _isSigningUpError = false;
    notifyListeners();
    try {
      final response = await AuthService.signUp(userSignUpModel);
      if (response.statusCode == 201) {
        _isSigningUpSuccess = true;
        return;
      } else {
        _isSigningUpError = true;
        return;
      }
    } catch (e) {
      _isSigningUpError = true;
      return;
    } finally {
      _isSigningUp = false;
      notifyListeners();
    }
  }

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  bool _isLoggingInError = false;
  bool get isLoggingInError => _isLoggingInError;

  bool _isLoggingInErrorInvalidCredentials = false;
  bool get isLoggingInErrorInvalidCredentials =>
      _isLoggingInErrorInvalidCredentials;

  bool _isLoggingInErrorNetwork = false;
  bool get isLoggingInErrorNetwork => _isLoggingInErrorNetwork;

  // bool _isLoggingInErrorTimeout = false;
  // bool get isLoggingInErrorTimeout => _isLoggingInErrorTimeout;

  Future<void> signIn(UserLoginModel userLoginModel) async {
    print(userLoginModel.toJson());
    _isLoggingIn = true;
    _isLoggingInError = false;
    _isLoggingInErrorInvalidCredentials = false;
    _isLoggingInErrorNetwork = false;
    // _isLoggingInErrorTimeout = false;
    notifyListeners();
    try {
      final response = await AuthService.login(userLoginModel);
      if (response.statusCode == 200) {
        _isLoggedIn = true;
        _setIsLoggedIn(true);
        return;
        // } else if (response.statusCode == 408) {
        //   _isLoggingInError = true;
        //   _isLoggingInErrorTimeout = true;
        //   return;
      } else {
        _isLoggingInError = true;
        _isLoggingInErrorInvalidCredentials = true;
        return;
      }
    } catch (e) {
      _isLoggingInError = true;
      _isLoggingInErrorNetwork = true;
      return;
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

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
        value: isSigningUp, ifTrue: 'Signing Up', ifFalse: 'Not Signing Up'));
    properties.add(FlagProperty('isLoggingIn',
        value: isLoggingIn, ifTrue: 'Signing In', ifFalse: 'Not Signing In'));
    properties.add(FlagProperty('isSigningOut',
        value: isSigningOut,
        ifTrue: 'Signing Out',
        ifFalse: 'Not Signing Out'));
  }
}
