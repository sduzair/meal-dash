import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/features/authentication/views/login/login_screen.dart';
import 'package:mealdash_app/features/authentication/views/signup/signup_screen.dart';
import 'package:mealdash_app/features/authentication/views/welcome/welcome_screen.dart';
import 'package:mealdash_app/features/mealplans/views/home_scaffold.dart';
import 'package:mealdash_app/features/mealplans/views/mealplans/mealplans_screen.dart';
import 'package:mealdash_app/features/mealplans/views/meals/meals_screen.dart';
import 'package:mealdash_app/features/orders/views/orders_screen.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class MyRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  final UserAuthViewModel userAuthViewModel;
  MyRouter(this.userAuthViewModel);

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: userAuthViewModel,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: constants.rootRouteName,
        path: '/',
        redirect: (context, state) =>
            state.namedLocation(constants.HomeNavTabRouteNames.meals.name),
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
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => HomeScaffoldWithBottomNav(
                key: state.pageKey,
                child: child,
              ),
          routes: [
            GoRoute(
              name: constants.HomeNavTabRouteNames.orders.name,
              path: '/orders',
              pageBuilder: (context, state) => const MaterialPage<void>(
                // key: state.pageKey,
                child: OrdersScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) => const DetailsScreen(label: 'A'),
              //   ),
              // ],
            ),
            GoRoute(
              name: constants.HomeNavTabRouteNames.mealplans.name,
              path: '/mealplans',
              pageBuilder: (context, state) => const MaterialPage<void>(
                // key: state.pageKey,
                child: MealPlansScreen(),
              ),
            ),
            GoRoute(
              name: constants.HomeNavTabRouteNames.meals.name,
              path: '/meals',
              pageBuilder: (context, state) => const MaterialPage<void>(
                // key: state.pageKey,
                child: MealsScreen(),
              ),
            ),
          ]

      )
    ],
    // TODO: Add Error Handler
    // errorPageBuilder: (context, state) => MaterialPage<void>(
    //   key: state.pageKey,
    //   child: ErrorPage(error: state.error),
    // ),
    redirect: (context, state) {
      if (!userAuthViewModel.isLoggedIn &&
          !(state.subloc == state.namedLocation(constants.loginRouteName)) &&
          !(state.subloc == state.namedLocation(constants.signupRouteName)) &&
          !(state.subloc == state.namedLocation(constants.welcomeRouteName))) {
        return state.namedLocation(constants.welcomeRouteName);
      } else {
        return null;
      }
    },
  );
}
