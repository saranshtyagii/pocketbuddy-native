import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procketbuddy_native/constants/Url_Constants.dart';
import 'package:procketbuddy_native/main.dart';
import 'package:procketbuddy_native/screens/Error_Screen.dart';
import 'package:procketbuddy_native/screens/Home_Screen.dart';
import 'package:procketbuddy_native/screens/Login_Screen.dart';
import 'package:procketbuddy_native/utils/User_Authentication.dart';
import 'package:procketbuddy_native/utils/User_Register.dart';
import 'package:procketbuddy_native/utils/user_deatils.dart';

class AuthServices {
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
        http.Response? loginResponse = await authenticateUser(
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
        return loginResponse;
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
        fetchLoginUserInfo(userData.getUsernameOrEmail());
        return response;
      } else {
        return response;
      }
    } catch (error) {
      _showErrorScreen();
    }
    return null;
  }

  void resetPassword() {}

  void fetchLoginUserInfo(String emailOrUsername) async {
    try {
      Uri uri = Uri.parse(
          "${UrlConstants.backendUrlV1}/user/find?usernameOrEmail=$emailOrUsername");

      String token = await fetchAuthToken();
      http.Response response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, String> userData = jsonDecode(response.body);
        UserDetails.saveUserDetails(userData);
      } else {
        _showErrorScreen();
      }
    } catch (error) {
      _showErrorScreen();
    }
  }

  static Future<String> fetchAuthToken() async {
    await storage.ready;
    String? token = storage.getItem("user_auth_token");
    if (token != null && token.isNotEmpty) {
      return token.toString();
    } else {
      storage.deleteItem("user_auth_token");
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
    return "";
  }

  _showErrorScreen() {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ErrorScreen(),
      ),
    );
  }
}
