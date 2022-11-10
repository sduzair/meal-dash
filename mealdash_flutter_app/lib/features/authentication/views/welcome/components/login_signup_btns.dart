import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: constants.defaultPaddingXLarge,
      ),
      child: Column(
        children: [
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                visualDensity: VisualDensity.comfortable,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                GoRouter.of(context).goNamed(constants.loginRouteName);
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: constants.defaultPadding),
          Hero(
            tag: "signup_btn",
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                visualDensity: VisualDensity.comfortable,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                GoRouter.of(context).goNamed(constants.signupRouteName);
              },
              child: Text(
                "Sign Up".toUpperCase(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
