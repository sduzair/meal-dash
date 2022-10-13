import 'package:flutter/material.dart';
import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/models/user_signup_model.dart';

import 'package:mealdash_app/features/authentication/views/signup/components/sign_up_top_image.dart';
import 'package:mealdash_app/features/authentication/views/signup/signup_screen2.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserSignUpModel _userSignUpModel = constants.isTestingSignUp
      ? UserSignUpModel.initializeDummyVals()
      : UserSignUpModel.empty();
  String _password1 = '';
  String _password2 = '';
  bool _isMatchPassword = true;
  _checkIfPasswordsMatch() {
    identical(_password1,_password2)
        ? _isMatchPassword = true
        : _isMatchPassword = false;
  }
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SignUpScreenTopImage(),
              ConstrainedBox(
                constraints: const BoxConstraints(),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: constants.defaultPadding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            cursorColor: constants.kPrimaryColor,
                            onSaved: (email) {
                              _userSignUpModel.email = email!;
                            },
                            validator: (email) {
                              if (email!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "Your email",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: constants.defaultPadding),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              cursorColor: constants.kPrimaryColor,
                              onSaved: (username) {
                                _userSignUpModel.username = username!;
                              },
                              validator: (username) {
                                if (username!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Your username",
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: constants.defaultPadding),
                            child: TextFormField(
                              onChanged: (pass1) {
                                _password1 = pass1;
                              },
                              onSaved: (newValue) {
                                _password1 = newValue!;
                                _userSignUpModel.password = newValue!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              cursorColor: constants.kPrimaryColor,
                              decoration: const InputDecoration(
                                hintText: "Your password",
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                          ),
                          TextFormField(
                            onChanged: (pass2) {
                              _password2 = pass2;
                            },
                            onSaved: (newValue) {
                              _password2 = newValue!;
                            },
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            cursorColor: constants.kPrimaryColor,
                            decoration: const InputDecoration(
                              hintText: "Re-enter your password",
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: constants.defaultPadding),
                          // AlreadyHaveAnAccountCheck(
                          //   login: false,
                          //   press: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) {
                          //           return LoginScreen();
                          //         },
                          //       ),
                          //     );
                          //   },
                          // ),
                          _isMatchPassword ? const Text("") : const Text("Passwords do not match")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // const SocalSignUp()
            ],

          ),
        ),
        // resizeToAvoidBottomInset: false,
        persistentFooterButtons: [
          Hero(
            tag: "signup_btn",
            child: ElevatedButton.icon(
              onPressed: () {
                _checkIfPasswordsMatch();
                if (!constants.isTestingSignUp &&
                    _formKey.currentState!.validate()  && _isMatchPassword) {
                  // if (true) {
                  _formKey.currentState!.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignUpScreen2(userSignUpModel: _userSignUpModel)),
                  );
                } else if (constants.isTestingSignUp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SignUpScreen2(userSignUpModel: _userSignUpModel)),
                  );
                }

              },
              icon: const Icon(Icons.navigate_next),
              label: const Text('NEXT'),
            ),
          ),
        ],
      ),
    );
  }
}
