import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';

import 'package:mealdash_app/features/authentication/repository/auth_service.dart';

class UserAuthViewModel with ChangeNotifier, DiagnosticableTreeMixin {

  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;

  // set isSigningUp(bool value) {
  //   _isSigningUp = value;
  //   notifyListeners();
  // }

  bool _isSigningUpError = false;
  bool get isSigningUpError => _isSigningUpError;

  // set isSigningUpError(bool value) {
  //   _isSigningUpError = value;
  //   notifyListeners();
  // }

  Future<void> signUp(UserSignUpModel userSignUpModel) async {
    print(userSignUpModel.toJson());
    _isSigningUp = true;
    _isSigningUpError = false;
    notifyListeners();
    try {
      final response = await AuthService.signUp(userSignUpModel);
      if (response.statusCode == 201) {
        _isSigningUpError = false;
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isSigningUp',
        value: isSigningUp, ifTrue: 'Signing Up', ifFalse: 'Not Signing Up'));
    properties.add(FlagProperty('isSigningIn',
        value: isSigningIn, ifTrue: 'Signing In', ifFalse: 'Not Signing In'));
    properties.add(FlagProperty('isSigningOut',
        value: isSigningOut,
        ifTrue: 'Signing Out',
        ifFalse: 'Not Signing Out'));
  }
}
