import 'package:flutter/material.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';

import 'package:mealdash_app/features/authentication/repository/auth_service.dart';

class UserAuthViewModel with ChangeNotifier {
  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  void setIsSigningUp(bool isSigningUp) {
    _isSigningUp = isSigningUp;
    notifyListeners();
  }

  Future<String> signUp(UserSignUpModel userSignUpModel) async {
    setIsSigningUp(true);
    try {
      final response = await AuthService.signUp(userSignUpModel);
      if (response.statusCode == 201) {
        return 'Signup successfull';
      } else {
        return 'Signup failed';
      }
    } catch (e) {
      return 'Network Error';
    } finally {
      setIsSigningUp(false);
    }
  }

  bool _isSigningIn = false;
  bool get isSigningIn => _isSigningIn;

  void setIsSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  bool _isSigningOut = false;
  bool get isSigningOut => _isSigningOut;

  void setIsSigningOut(bool isSigningOut) {
    _isSigningOut = isSigningOut;
    notifyListeners();
  }
}
