import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:json_theme/json_theme.dart';
import 'package:mealdash_app/features/authentication/repository/auth_service.dart';
import 'package:mealdash_app/features/authentication/repository/verify_email_service.dart';
import 'package:mealdash_app/features/meals/repository/meal_service.dart';
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
    await SharedPreferences.getInstance(),
  );
  getIt.registerSingleton(DioClient());
  await getIt<DioClient>().init();
  // getIt.registerSingleton(DioClient(dio: getIt<Dio>()));
  // REGISTER API SERVICES HERE
  getIt.registerSingleton<AuthService>(
    AuthService(dioClient: getIt<DioClient>()),
  );
  getIt.registerSingleton<MealService>(
    MealService(dioClient: getIt<DioClient>()),
  );
  getIt.registerSingleton<VerifyEmailService>(
    VerifyEmailService(dioClient: getIt<DioClient>()),
  );
  constants.clearSharedPrefs
      ? await getIt.get<SharedPreferences>().clear()
      : null;
  // print the shared prefs to the console for debugging purposes only (not for production)
  getIt.get<SharedPreferences>().getKeys().forEach((key) {
    print('key: $key, value: ${getIt.get<SharedPreferences>().get(key)}');
  });
  getIt.registerSingleton<UserAuthViewModel>(
    UserAuthViewModel(
      prefs: getIt<SharedPreferences>(),
      authService: getIt<AuthService>(),
      isLoggedIn:
          getIt.get<SharedPreferences>().getBool(constants.loggedinKey) ??
              false,
    ),
  );
  constants.isTestUserLoggedIn
      ? await getIt.get<UserAuthViewModel>().loginTestUser()
      : null;


  // load the theme data
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  getIt.registerSingleton<ThemeData>(theme);

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
        ChangeNotifierProvider<SnackbarMessageProvider>(
          lazy: false,
          create: (BuildContext createContext) => SnackbarMessageProvider(),
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
                elevation: constants.defaultElevationSmall,
              ),
              bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
                // elevation: constants.defaultElevation,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: theme.colorScheme.primary,
                unselectedItemColor: theme.colorScheme.onSurface,
                // selectedIconTheme: theme.iconTheme.copyWith(
                //   color: theme.colorScheme.primary,
                // ),
                // selectedLabelStyle: theme.textTheme.bodyText2!.copyWith(
                //   color: theme.colorScheme.primary,
                // ),
                // unselectedIconTheme: theme.iconTheme.copyWith(
                //   color: theme.colorScheme.primaryContainer,
                // ),
                // unselectedLabelStyle: theme.textTheme.bodyText2!.copyWith(
                //   color: theme.colorScheme.primaryContainer,
                // ),
              ),
              inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue[600]!,
                    width: 2,
                  ),
                ),
                // floatingLabelStyle: theme.textTheme.bodyText2!.copyWith(
                //   color: theme.colorScheme.secondary,
                // ),
                floatingLabelStyle: theme.textTheme.bodyText1!.copyWith(
                  color: theme.colorScheme.secondary,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              chipTheme: theme.chipTheme.copyWith(
                backgroundColor: theme.colorScheme.onPrimary,
                disabledColor: theme.colorScheme.primaryContainer,
                selectedColor: theme.colorScheme.primary,
                labelStyle: theme.textTheme.bodyText2!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
                secondaryLabelStyle: theme.textTheme.bodyText2!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                deleteIconColor: theme.colorScheme.onPrimary,
              ),
              bottomSheetTheme: theme.bottomSheetTheme.copyWith(
                // backgroundColor: theme.colorScheme.primaryContainer,
                elevation: constants.defaultElevation,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SnackbarMessageProvider with ChangeNotifier {
  SnackbarMessageType _snackbarMessage = SnackbarMessageType.reset();

  SnackbarMessageType get snackbarMessage => _snackbarMessage;

  set snackbarMessage(SnackbarMessageType snackbarMessageType) {
    _snackbarMessage = snackbarMessageType;
  }

  void resetSnackbarMessage() {
    _snackbarMessage = SnackbarMessageType.reset();
  }
}

class SnackbarMessageType {
  late final String message;
  late final bool showMessage;
  late final Color color;
  late final IconData icon;

  SnackbarMessageType.reset({
    this.message = '',
    this.showMessage = false,
    this.color = Colors.green,
    this.icon = Icons.check,
  });

  SnackbarMessageType.set({
    required this.message,
    required this.showMessage,
    this.color = Colors.green,
    this.icon = Icons.check,
  });
}
