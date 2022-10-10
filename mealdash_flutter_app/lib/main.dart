import 'package:flutter/material.dart';

import 'package:mealdash_app/features/authentication/views/welcome/welcome_screen.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: constants.kPrimaryColor,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: constants.kPrimaryColor),
          // scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
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
            // contentPadding: EdgeInsets.symmetric(
            //     horizontal: defaultPadding, vertical: defaultPadding),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(30)),
            //   borderSide: BorderSide.none,
            // ),
          )),
      home: const WelcomeScreen(),
    );
  }
}
