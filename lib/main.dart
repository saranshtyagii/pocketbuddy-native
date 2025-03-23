import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:localstorage/localstorage.dart';
import 'package:procketbuddy_native/screens/Home_Screen.dart';
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
final LocalStorage storage = LocalStorage('pocket_buddy@_app');

class MyApp extends StatelessWidget {
  final ThemeData lightThemeData;
  const MyApp({super.key, required this.lightThemeData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightThemeData,
      home: FutureBuilder(
        future: _havingAuthenticationToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data != null) {
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }

  Future<bool> _havingAuthenticationToken() async {
    await storage.ready;
    String? token = storage.getItem("user_auth_token");
    return token != null && token.isNotEmpty;
  }
}
