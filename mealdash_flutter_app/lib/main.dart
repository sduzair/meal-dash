import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:json_theme/json_theme.dart';
import 'package:mealdash_app/features/authentication/repository/auth_service.dart';
import 'package:mealdash_app/router/routes.dart';
import 'package:mealdash_app/service_locator.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  constants.isTestUserLoggedIn
      ? await getIt<SharedPreferences>().setBool(constants.loggedInKey, true)
      : await getIt<SharedPreferences>().setBool(constants.loggedInKey, false);
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(DioClient(dio: getIt<Dio>()));
  getIt.registerSingleton<AuthService>(
      AuthService(dioClient: getIt<DioClient>()));
  getIt.registerSingleton<UserAuthViewModel>(UserAuthViewModel(
      prefs: getIt<SharedPreferences>(), authService: getIt<AuthService>()));
  getIt.get<UserAuthViewModel>().checkLoggedIn();

  // load the theme data
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme, userAuthViewModel: getIt<UserAuthViewModel>()));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final UserAuthViewModel userAuthViewModel;
  const MyApp({Key? key, required this.theme, required this.userAuthViewModel})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthViewModel>(
          lazy: false,
          create: (BuildContext createContext) => userAuthViewModel,
        ),
        Provider<MyRouter>(
          lazy: false,
          create: (BuildContext createContext) => MyRouter(userAuthViewModel),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final router = Provider.of<MyRouter>(context, listen: false).router;
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Auth',
            theme: theme.copyWith(
              bannerTheme: theme.bannerTheme.copyWith(
                elevation: constants.defaultElevation,
              ),
            ),
          );
        },
      ),
    );
  }
}
