import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: context.read<UserAuthViewModel>().userLoginDTO.email,
            onSaved: (email) {
              context.read<UserAuthViewModel>().userLoginDTO.email = email!;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            // cursorColor: constants.kPrimaryColor,
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
              initialValue:
                  context.read<UserAuthViewModel>().userLoginDTO.password,
              onSaved: (newValue) {
                context.read<UserAuthViewModel>().userLoginDTO.password =
                    newValue!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
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
          UserLoginButton(formKey: _formKey),
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
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Hero(
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
          if (context.read<UserAuthViewModel>().isLoggingIn ||
              context.read<UserAuthViewModel>().isLoggingInSuccess) {
            // print("Already logging in");
            return;
          }
          // IF TESING LOGIN LOGIN DUMMY USER AND RETURN EARLY
          if (constants.isTestingLogin) {
            context.read<UserAuthViewModel>().login();
            return;
          }
          // IF NOT TESTING LOGIN VALIDATE FORM AND LOGIN USER IF VALID
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            context.read<UserAuthViewModel>().login();
          }
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
    final authVMWatch = context.watch<UserAuthViewModel>();
    if (authVMWatch.isLoggingIn) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    } else if (authVMWatch.isLoggingInError) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(
              authVMWatch.loginErrorMessage!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.error,
              child: const Icon(Icons.error),
            ),
            actions: [
              if (authVMWatch.isLoggingInErrorUnverifiedEmail)
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    context.read<UserAuthViewModel>().resetLoginState();
                    GoRouter.of(context)
                        .goNamed(constants.signupEmailVerificationRouteName);
                  },
                  child: Text(
                    "VERIFY EMAIL",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  context
                      .read<UserAuthViewModel>()
                      .resetLoginStateAndNotifyListeners();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              )
            ],
          ),
        );
      });
      return const Text("LOGIN");
    } else if (authVMWatch.isLoggingInSuccess) {
      ScaffoldMessenger.of(context).clearMaterialBanners();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // * RESETTING LOGIN STATE ON MEALS HOME PAGE WITHOUT NOTIFIYING LISTENERS AS ROUTING IS GETTING INTERFERED WHEN NOTIFIYING LISTENERS
        GoRouter.of(context).goNamed(constants.HomeNavTabRouteNames.meals.name);
      });

      return const SizedBox(
        height: 20,
        width: 20,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } else {
      return const Text("LOGIN");
    }
  }
}
