import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/features/authentication/models/user_login_model.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';

import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final UserLoginModel _userLoginModel = constants.isTestingLogin
      ? UserLoginModel.initializeDummyVals()
      : UserLoginModel.empty();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (email) {
              _userLoginModel.email = email!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: constants.kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(constants.defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: constants.defaultPadding),
            child: TextFormField(
              onSaved: (newValue) {
                _userLoginModel.password = newValue!;
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
                prefixIcon: Padding(
                  padding: EdgeInsets.all(constants.defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: constants.defaultPadding),
          UserLoginButton(formKey: _formKey, userLoginModel: _userLoginModel),
          const SizedBox(height: constants.defaultPadding),
        ],
      ),
    );
  }
}

class UserLoginButton extends StatelessWidget {
  const UserLoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required UserLoginModel userLoginModel,
  })  : _formKey = formKey,
        _userLoginModel = userLoginModel,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final UserLoginModel _userLoginModel;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "login_btn",
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: constants.kPrimaryColor,
            elevation: constants.defaultElevation),
        onPressed: () {
          if (context.read<UserAuthViewModel>().isLoggingIn) {
            // print("Already logging in");
            return;
          }
          if (!constants.isTestingLogin && _formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
          // context.read<UserAuthViewModel>().signIn(_userLoginModel);
          // if (context.read<UserAuthViewModel>().isLoggedIn) {
          context.goNamed(constants.homeRouteName);
          // }
        },
        child: const TextUserLoginButton(),
      ),
    );
  }
}

class TextUserLoginButton extends StatelessWidget {
  const TextUserLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserAuthViewModel>(
      builder: (context, authViewModel, child) {
        if (authViewModel.isLoggingIn) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (authViewModel.isLoggingInErrorInvalidCredentials) {
          return const Text(
            "INVALID CREDENTIALS TRY AGAIN",
            style: TextStyle(color: Colors.white),
          );
        } else if (authViewModel.isLoggingInErrorUnknown) {
          return const Text(
            "UNKNOWN ERROR TRY AGAIN",
            style: TextStyle(color: Colors.white),
          );
          // } else if (authViewModel.isLoggingInError &&
          //     authViewModel.isLoggingInErrorTimeout) {
          //   return const Text(
          //     "TIMEOUT ERROR TRY AGAIN",
          //     style: TextStyle(color: Colors.white),
          //   );
        } else if (authViewModel.isLoggedIn) {
          return const SizedBox(
            height: 20,
            width: 20,
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          );
        } else {
          return const Text(
            "LOGIN",
            style: TextStyle(color: Colors.white),
          );
        }
      },
    );
  }
}
