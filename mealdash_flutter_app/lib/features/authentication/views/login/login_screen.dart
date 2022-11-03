import 'package:flutter/material.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:go_router/go_router.dart';

import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/views/login/components/login_form.dart';
import 'package:mealdash_app/features/authentication/views/login/components/login_screen_top_image.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: MobileLoginScreen(),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<UserAuthViewModel>().isShowSignupSuccessPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Signup successful for ${context.read<UserAuthViewModel>().userSignUpModel.email}!'),
          ),
        );
      });
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              context.read<UserAuthViewModel>().resetLoginAndNotifyListeners();
              context.goNamed(constants.welcomeRouteName);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          LoginScreenTopImage(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constants.defaultPaddingLarge,
              ),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}
