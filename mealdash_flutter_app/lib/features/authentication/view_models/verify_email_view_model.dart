import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/authentication/repository/verify_email_service.dart';
import 'package:mealdash_app/service_locator.dart';

class VerifyEmailViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final VerifyEmailService verifyEmailService;

  VerifyEmailViewModel({required this.verifyEmailService});

  bool _isVerifyngEmail = false;
  bool get isVerifyngEmail => _isVerifyngEmail;

  bool _isVerifyingEmailError = false;
  bool get isVerifyingEmailError => _isVerifyingEmailError;

  String? _verifyingEmailErrorMessage;
  String? get verifyingEmailErrorMessage => _verifyingEmailErrorMessage;

  bool _isVerifyingEmailSuccess = false;
  bool get isVerifyingEmailSuccess => _isVerifyingEmailSuccess;

  bool _showVerifyingEmailSuccessPopup = false;
  bool get showVerifyingEmailSuccessPopup => _showVerifyingEmailSuccessPopup;

  Future<void> verifyEmail(String email) async {
    print('verifyEmail() called');
    resetVerifyEmailState();
    _isVerifyngEmail = true;
    notifyListeners();
    try {
      await verifyEmailService.verifyEmail(email);
      _isVerifyingEmailSuccess = true;
      _showVerifyingEmailSuccessPopup = true;
    } on DioError catch (e) {
      _isVerifyingEmailError = true;
      _verifyingEmailErrorMessage = DioExceptions.fromDioError(e).toString();
    } finally {
      _isVerifyngEmail = false;
      notifyListeners();
    }
  }

  resetVerifyEmailStateAndNotifyListeners() {
    _isVerifyngEmail = false;
    _isVerifyingEmailError = false;
    _verifyingEmailErrorMessage = null;
    _isVerifyingEmailSuccess = false;
    _showVerifyingEmailSuccessPopup = false;
    notifyListeners();
  }

  resetVerifyEmailState() {
    _isVerifyngEmail = false;
    _isVerifyingEmailError = false;
    _verifyingEmailErrorMessage = null;
    _isVerifyingEmailSuccess = false;
    _showVerifyingEmailSuccessPopup = false;
  }

  void resetVerifyEmailSuccessPopup() {
    _showVerifyingEmailSuccessPopup = false;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'isVerifyngEmail',
        value: _isVerifyngEmail,
        ifTrue: 'isVerifyngEmail',
      ),
    );
    properties.add(
      FlagProperty(
        'isVerifyingEmailError',
        value: _isVerifyingEmailError,
        ifTrue: 'isVerifyingEmailError',
      ),
    );
    properties.add(
      StringProperty(
        'verifyingEmailErrorMessage',
        _verifyingEmailErrorMessage ?? 'null',
      ),
    );
    properties.add(
      FlagProperty(
        'isVerifyingEmailSuccess',
        value: _isVerifyingEmailSuccess,
        ifTrue: 'isVerifyingEmailSuccess',
      ),
    );
    properties.add(
      FlagProperty(
        'showVerifyingEmailSuccessPopup',
        value: _showVerifyingEmailSuccessPopup,
        ifTrue: 'showVerifyingEmailSuccessPopup',
      ),
    );
  }
}
