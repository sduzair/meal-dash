import 'package:flutter/material.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:go_router/go_router.dart';

import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/views/login/components/login_form.dart';
import 'package:mealdash_app/features/authentication/views/login/components/login_screen_top_image.dart';

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
              // Navigator.pop(context);
              // context.pop();
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
