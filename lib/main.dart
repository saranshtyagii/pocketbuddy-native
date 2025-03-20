import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:procketbuddy_native/screens/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final lightThemeString =
      await rootBundle.loadString("assets/themes/theme_light.json");
  final lightJsonTheme = jsonDecode(lightThemeString);
  final lightTheme = ThemeDecoder.decodeThemeData(lightJsonTheme)!;

  runApp(MyApp(lightThemeData: lightTheme));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final ThemeData lightThemeData;
  const MyApp({super.key, required this.lightThemeData});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightThemeData,
        home: const LoginScreen());
  }
}
