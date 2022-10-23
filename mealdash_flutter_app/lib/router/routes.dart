import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/features/authentication/views/login/login_screen.dart';
import 'package:mealdash_app/features/authentication/views/signup/signup_screen.dart';
import 'package:mealdash_app/features/authentication/views/welcome/welcome_screen.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class MyRouter {
  // 1
  final UserAuthViewModel userAuthViewModel;
  MyRouter(this.userAuthViewModel);

  // 2
  late final router = GoRouter(
    // 3
    refreshListenable: userAuthViewModel,
    // 4
    debugLogDiagnostics: true,
    // 5
    // urlPathStrategy: UrlPathStrategy.path,

    // 6
    routes: [
      GoRoute(
        name: constants.rootRouteName,
        path: '/',
        redirect: (context, state) =>
            state.namedLocation(constants.welcomeRouteName),
      ),
      GoRoute(
        name: constants.welcomeRouteName,
        path: '/welcome',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const WelcomeScreen(),
        ),
      ),
      GoRoute(
        name: constants.loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: constants.signupRouteName,
        path: '/signup',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SignupScreen(),
        ),
      ),
    ],
    // TODO: Add Error Handler
    // errorPageBuilder: (context, state) => MaterialPage<void>(
    //   key: state.pageKey,
    //   child: ErrorPage(error: state.error),
    // ),
    // TODO Add Redirect
  );
}
