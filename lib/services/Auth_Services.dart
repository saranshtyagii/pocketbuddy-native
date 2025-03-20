import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:procketbuddy_native/constants/Url_Constants.dart';
import 'package:procketbuddy_native/main.dart';
import 'package:procketbuddy_native/screens/Error_Screen.dart';
import 'package:procketbuddy_native/screens/Home_Screen.dart';
import 'package:procketbuddy_native/utils/User_Authentication.dart';
import 'package:procketbuddy_native/utils/User_Register.dart';

class AuthServices {
  final LocalStorage storage = new LocalStorage('pocket_buddy@_app');

  Future<http.Response?> createUserAccount(UserRegister userData) async {
    try {
      Uri uri = Uri.parse("${UrlConstants.backendUrlV1}/auth/register");
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: UserRegister.convertToJson(userData),
      );
      if (response.statusCode == 200) {
        authenticateUser(
          UserAuthentication(
            usernameOrEmail: userData.email,
            password: userData.password,
            "",
            "",
            "",
            "",
            "",
            "",
          ),
        );
      }
    } catch (error) {
      _showErrorScreen();
    }
    return null;
  }

  Future<http.Response?> authenticateUser(UserAuthentication userData) async {
    try {
      Uri uri = Uri.parse("${UrlConstants.backendUrlV1}/auth/login");
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: UserAuthentication.convertToJson(userData),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> userLoginData = jsonDecode(response.body);
        storage.setItem("user_auth_token", userLoginData["token"]);
        return response;
      }
    } catch (error) {
      _showErrorScreen();
    }
    return null;
  }

  _showErrorScreen() {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ErrorScreen(),
      ),
    );
  }
}
