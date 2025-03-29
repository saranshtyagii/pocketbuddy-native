import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_theme/json_theme.dart';
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
final FlutterSecureStorage storage = FlutterSecureStorage();

class MyApp extends StatelessWidget {
  final ThemeData lightThemeData;
  const MyApp({super.key, required this.lightThemeData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Buddy',
      theme: lightThemeData,
      home: FutureBuilder<bool>(
        future: _havingAuthenticationToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  Future<bool> _havingAuthenticationToken() async {
    String? token = await storage.read(key: 'user_auth_token');
    return token != null && token.isNotEmpty;
  }
}
