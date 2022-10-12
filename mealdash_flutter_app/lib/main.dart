import 'package:mealdash_app/features/mealplans/views/main_menu.dart';

import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mealdash_app/features/authentication/views/welcome/welcome_screen.dart';

import 'package:mealdash_app/features/authentication/view_models/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserAuthViewModel()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: constants.isLogginIn
          ? const FoodVendorMainMenu()
          : const WelcomeScreen(),
    );
  }
}
