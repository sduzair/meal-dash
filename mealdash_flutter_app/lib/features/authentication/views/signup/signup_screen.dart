import 'package:flutter/material.dart';
import '../../../../components/background.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_form.dart';
import 'signup_screen2.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Responsive(
        mobile: const MobileSignupScreen(),
        desktop: Row(
          children: [
            const Expanded(
              child: SignUpScreenTopImage(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 450,
                    child: SignUpForm(),
                  ),
                  SizedBox(height: defaultPadding / 2),
                  // SocalSignUp()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SignUpScreenTopImage(),
              Row(
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignUpForm(),
                  ),
                  Spacer(),
                ],
              ),
              // const SocalSignUp()
            ],
          ),
        ),
      ),
      // resizeToAvoidBottomInset: false,
      persistentFooterButtons: [
        Hero(
          tag: "signup_btn",
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen2()));
            },
            icon: const Icon(Icons.navigate_next),
            label: const Text('NEXT'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 20,
            ),
          ),
        ),
      ],
    );
  }
}
