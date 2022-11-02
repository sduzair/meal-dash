import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: constants.defaultElevation,
            ),
            onPressed: () {
              GoRouter.of(context).goNamed(constants.loginRouteName);
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Hero(
          tag: "signup_btn",
          child: ElevatedButton(
            onPressed: () {
              GoRouter.of(context).goNamed(constants.signupRouteName);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: constants.kPrimaryLightColor,
                elevation: constants.defaultElevation),
            child: Text(
              "Sign Up".toUpperCase(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
