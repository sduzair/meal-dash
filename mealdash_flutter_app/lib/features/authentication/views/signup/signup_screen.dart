import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/components/background.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';

import 'package:mealdash_app/features/authentication/views/signup/components/sign_up_top_image.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password1 = '';
  String _password2 = '';
  String _passmatch = '';
  bool _isMatchPassword = true;
  _checkIfPasswordsMatch() {
    setState(() {
      if(_password1 == _password2) {
        _isMatchPassword = true;
        _passmatch = '';
      } else {
        _isMatchPassword = false;
        _passmatch = 'Passwords do not match';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                context.goNamed(constants.welcomeRouteName);
                // GoRouter.of(context).navigator?.pop();
                // Navigator.maybePop(context);
              },
            ),
          ],
        ),
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
                              context
                                  .read<UserAuthViewModel>()
                                  .userSignUpModel
                                  .email = email;
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
                                context
                                    .read<UserAuthViewModel>()
                                    .userSignUpModel
                                    .username = username;
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
                              onSaved: (password) {
                                context
                                    .read<UserAuthViewModel>()
                                    .userSignUpModel
                                    .password = password;
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
                          Text(_passmatch),
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
                if (!_isMatchPassword) {
                  return;
                }
                if (!constants.isTestingSignUp &&
                    _formKey.currentState!.validate() &&
                    _isMatchPassword) {
                  _formKey.currentState!.save();
                }
                GoRouter.of(context).goNamed(constants.signupStep2RouteName); 
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
