import 'package:flutter/material.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/views/welcome/components/login_signup_btns.dart';
import 'package:mealdash_app/features/authentication/views/welcome/components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: MobileWelcomeScreen(),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        WelcomeImage(),
        SizedBox(height: constants.defaultPaddingXLarge),
        Expanded(child: LoginAndSignupBtn()),
      ],
    );
  }
}
