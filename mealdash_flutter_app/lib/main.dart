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
                backgroundColor: constants.kPrimaryColor,
              ),
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
                iconColor: constants.kPrimaryColor,
                prefixIconColor: constants.kPrimaryColor,
                // isDense: true,
                // alignLabelWithHint: false,
                // isCollapsed: true,
                // contentPadding: EdgeInsets.all(0),
              ),
              appBarTheme: const AppBarTheme(
                elevation: constants.defaultElevationSmall,
                backgroundColor: constants.kPrimaryColor,
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.white,
                elevation: constants.defaultElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(constants.borderRadius),
                    topRight: Radius.circular(constants.borderRadius),
                  ),
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                elevation: constants.defaultElevation,
                selectedItemColor: constants.kPrimaryColor,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
              ),
              chipTheme: ChipThemeData(
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                backgroundColor: Colors.lightBlue.shade600,
                // selectedColor: Colors.,
                disabledColor: Colors.grey,
                labelStyle: const TextStyle(color: Colors.white),
              ),
              fontFamily: 'Poppins',
              dividerTheme: const DividerThemeData(
                color: constants.kPrimaryColor,
                thickness: 2,
                space: 0,
                indent: 0,
                endIndent: 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
