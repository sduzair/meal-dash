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
    // * RESETTING STATE OF PREVIOUS LOGIN ATTEMPT, THIS COULD NOT BE DONE ON MEALS HOME PAGE OR LOGOUT BUTTON CLICK
    // context.read<UserAuthViewModel>().resetLoginStateAndNotifyListeners();
    if (context.read<UserAuthViewModel>().showSignupSuccessPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Signup successful for ${context.read<UserAuthViewModel>().userSignUpDTO.email}!',
            ),
          ),
        );
      });
      context.read<UserAuthViewModel>().resetSignUpState();
    }
    if (context.read<UserAuthViewModel>().showLoggingOutSuccessPopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Logged out successfully!',
            ),
          ),
        );
        context.read<UserAuthViewModel>().resetLogoutState();
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
              // // AFTER SUCCESSFUL SIGNUP
              // context
              //     .read<UserAuthViewModel>()
              //     .resetLoginStateAndNotifyListeners();
              // // AFTER SUCCESSFUL LOGOUT
              // context
              //     .read<UserAuthViewModel>()
              //     .resetLogoutStateAndNotifyListeners();
              context.goNamed(constants.welcomeRouteName);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            LoginScreenTopImage(),
            SizedBox(height: constants.defaultPadding * 2),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constants.defaultPaddingLarge,
              ),
              child: LoginForm(),
            ),
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: const [
      //       Expanded(child: LoginScreenTopImage()),
      //       Expanded(
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(
      //             horizontal: constants.defaultPaddingLarge,
      //           ),
      //           child: LoginForm(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
