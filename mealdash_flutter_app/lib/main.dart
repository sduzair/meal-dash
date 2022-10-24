import 'package:mealdash_app/router/routes.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  constants.isTestUserLoggedIn
      ? await prefs.setBool(constants.loggedInKey, true)
      : await prefs.setBool(constants.loggedInKey, false);
  final userAuthViewModel =
      UserAuthViewModel(prefs);
  // constants.isTestUserLoggedIn ? userAuthViewModel.loginTestUser() : null;
  userAuthViewModel.checkLoggedIn();

  runApp(MyApp(userAuthViewModel: userAuthViewModel));
}

class MyApp extends StatelessWidget {
  final UserAuthViewModel userAuthViewModel;
  const MyApp({Key? key, required this.userAuthViewModel}) : super(key: key);

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
            theme: ThemeData(
                // useMaterial3: true,
                primaryColor: constants.kPrimaryColor,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: constants.kPrimaryColor),
                // scaffoldBackgroundColor: Colors.white,
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    elevation: constants.defaultElevation,
                    backgroundColor: constants.kPrimaryColor,
                    shape: const StadiumBorder(),
                    maximumSize: const Size(double.infinity, 56),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  // filled: true,
                  // fillColor: kPrimaryLightColor,
                  iconColor: constants.kPrimaryColor,
                  prefixIconColor: constants.kPrimaryColor,
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: constants.kPrimaryColor),
                  //   // borderRadius: BorderRadius.all(Radius.circular(50)),
                  // ),
                  // contentPadding: EdgeInsets.symmetric(
                  //     horizontal: defaultPadding, vertical: defaultPadding),
                ),
                appBarTheme: const AppBarTheme(
                  elevation: constants.defaultElevationSmall,
                  backgroundColor: constants.kPrimaryColor,
                )),
          );
        },
      ),
    );
  }
}
