import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:mealdash_app/features/authentication/views/login/login_screen.dart';
import 'package:mealdash_app/features/authentication/views/signup/signup_screen.dart';
import 'package:mealdash_app/features/authentication/views/welcome/welcome_screen.dart';
import 'package:mealdash_app/features/mealplans/view_models/meal_view_model.dart';
import 'package:mealdash_app/features/mealplans/views/home_scaffold.dart';
import 'package:mealdash_app/features/mealplans/views/mealplans/mealplans_screen.dart';
import 'package:mealdash_app/features/mealplans/views/meals/add/meals_add_screen.dart';
import 'package:mealdash_app/features/mealplans/views/meals/details/meals_details_screen.dart';
import 'package:mealdash_app/features/mealplans/views/meals/edit/meals_edit_screen.dart';
import 'package:mealdash_app/features/mealplans/views/meals/meals_screen.dart';
import 'package:mealdash_app/features/orders/views/orders_screen.dart';
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
            key: state.pageKey, child: const WelcomeScreen()),
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
        pageBuilder: (context, state) =>
            MaterialPage<void>(key: state.pageKey, child: const SignupScreen()),
      ),
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
                    ChangeNotifierProvider<MealViewModel>(
                        create: (_) => MealViewModel()),
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
                              create: (context) => IngredientsProvider())
                        ],
                        child: const MealsAddScreen(),
                      ),
                    ),
                    GoRoute(
                      name: constants.mealsEditRouteName,
                      path: 'edit/:id',
                      builder: (context, state) {
                        print('state.params: ${state.params['id']}');
                        return MealsEditScreen(
                          mealId: state.params['id'] as String,
                        );
                      },
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
          !(state.subloc == state.namedLocation(constants.welcomeRouteName))) {
        return state.namedLocation(constants.welcomeRouteName);
      } else {
        return null;
      }
    },
  );
}
