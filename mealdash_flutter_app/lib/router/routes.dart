import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/features/authentication/repository/verify_email_service.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/features/authentication/view_models/verify_email_view_model.dart';
import 'package:mealdash_app/features/authentication/views/login/login_screen.dart';
import 'package:mealdash_app/features/authentication/views/signup/signup_screen.dart';
import 'package:mealdash_app/features/authentication/views/signup/signup_screen2.dart';
import 'package:mealdash_app/features/authentication/views/verification/verify_email_screen.dart';
import 'package:mealdash_app/features/authentication/views/welcome/welcome_screen.dart';
import 'package:mealdash_app/features/mealplans/views/mealplans_screen.dart';
import 'package:mealdash_app/features/meals/repository/meal_service.dart';
import 'package:mealdash_app/features/meals/view_models/meal_view_model.dart';
import 'package:mealdash_app/features/home/views/home_scaffold.dart';
import 'package:mealdash_app/features/meals/views/meals_screen.dart';
import 'package:mealdash_app/features/meals/views/add/meals_add_screen.dart';
import 'package:mealdash_app/features/meals/views/details/meals_details_screen.dart';
import 'package:mealdash_app/features/meals/views/edit/meals_edit_screen.dart';
import 'package:mealdash_app/features/orders/views/orders_screen.dart';
import 'package:mealdash_app/main.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class MyRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  final _mealsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'meals');

  final UserAuthViewModel userAuthViewModel;
  MyRouter(this.userAuthViewModel);

  late final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: userAuthViewModel,
    debugLogDiagnostics: true,
    restorationScopeId: 'sadfasf',
    routes: <RouteBase>[
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
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: const LoginScreen()),
      ),
      GoRoute(
        name: constants.signupRouteName,
        path: '/signup',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SignupScreen(),
        ),
        routes: [
          GoRoute(
            name: constants.signupStep2RouteName,
            path: 'step2',
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const SignUpScreen2(),
            ),
          ),
        ],
      ),
      GoRoute(
        name: constants.signupEmailVerificationRouteName,
        path: '/verify-email',
        builder: (context, state) => MultiProvider(
          providers: [
            ChangeNotifierProvider<VerifyEmailViewModel>(
              create: (_) => VerifyEmailViewModel(
                verifyEmailService: getIt.get<VerifyEmailService>(),
              ),
            ),
          ],
          child: const VerifyEmailScreen(
            // TODO: to get email two possible ways
            // TODO: 1- pass email from signup screen to shared preferences to here
            // TODO: 2- pass email from login screen when user unverified to shared preferences to here
            userEmail: "todo@asdf.com",
          ),
        ),
      ),
      // GoRoute(
      //   name: constants.signupRouteName,
      //   path: '/signup',
      //   pageBuilder: (context, state) =>
      //       MaterialPage<void>(key: state.pageKey, child: const SignupScreen()),
      //   routes: [
      //     GoRoute(
      //       name: constants.signupStep2RouteName,
      //       path: 'step2',
      //       pageBuilder: (context, state) => MaterialPage<void>(
      //           key: state.pageKey, child: const SignupScreen()),
      //     ),
      //   ],
      // ),
      StatefulShellRoute(
        branches: <ShellRouteBranch>[
          ShellRouteBranch(
            rootRoute: GoRoute(
              name: constants.HomeNavTabRouteNames.home.name,
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ),
          ShellRouteBranch(
            rootRoute: GoRoute(
              name: constants.HomeNavTabRouteNames.orders.name,
              path: '/orders',
              builder: (context, state) => const OrdersScreen(),
            ),
          ),
          ShellRouteBranch(
            rootRoute: GoRoute(
              name: constants.HomeNavTabRouteNames.mealplans.name,
              path: '/mealplans',
              builder: (context, state) => const MealPlansScreen(),
            ),
          ),
          ShellRouteBranch(
            defaultLocation: '/meals',
            rootRoute: ShellRoute(
              pageBuilder: (context, state, child) => MaterialPage<void>(
                key: state.pageKey,
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<MealAddViewModel>(
                      create: (_) => MealAddViewModel(
                        mealService: getIt.get<MealService>(),
                      ),
                    ),
                  ],
                  child: child,
                ),
              ),
              routes: <RouteBase>[
                GoRoute(
                  name: constants.HomeNavTabRouteNames.meals.name,
                  path: '/meals',
                  builder: (context, state) => const MealsScreen(),
                  routes: <RouteBase>[
                    GoRoute(
                      name: constants.mealsAddRouteName,
                      path: 'add',
                      builder: (context, state) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => IngredientsProviderAdd(),
                          )
                        ],
                        child: const MealAddScreen(),
                      ),
                    ),
                    GoRoute(
                      name: constants.mealsEditRouteName,
                      path: 'edit/:id',
                      builder: (context, state) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (context) => IngredientsProviderEdit(),
                          )
                        ],
                        child: MealsEditScreen(
                          mealId: state.params['id'] as String,
                        ),
                      ),
                    ),
                    GoRoute(
                      name: constants.mealsDetailRouteName,
                      path: 'details/:id',
                      builder: (context, state) {
                        print('state.params: ${state.params['id']}');
                        return MealsDetailScreen(
                          mealId: state.params['id'] as String,
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
        builder: (context, state, child) => HomeScaffoldWithBottomNav(
          key: _shellNavigatorKey,
          child: child,
        ),
        pageBuilder: (context, state, child) => NoTransitionPage<void>(
          key: state.pageKey,
          child: child,
        ),
      ),
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
          !(state.subloc ==
              state.namedLocation(constants.signupStep2RouteName)) &&
          !(state.subloc == state.namedLocation(constants.welcomeRouteName)) &&
          !(state.subloc ==
              state
                  .namedLocation(constants.signupEmailVerificationRouteName))) {
        print(
          'redirecting to welcome screen as user is not logged in or not logging in',
        );
        print(state.subloc);
        return state.namedLocation(constants.welcomeRouteName);
      } else {
        return null;
      }
    },
  );
}
