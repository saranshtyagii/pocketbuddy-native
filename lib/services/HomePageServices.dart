import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procketbuddy_native/constants/Url_Constants.dart';
import 'package:procketbuddy_native/main.dart';
import 'package:procketbuddy_native/screens/Error_Screen.dart';
import 'package:procketbuddy_native/services/Auth_Services.dart';

class Homepageservices {
  loadHomeScreen() {}

  addExpense(String screen, String decs, String amount) {
    print("Hit from the $screen");
  }

  void fetchUserPersonalExpense() async {
    try {
      String? token = await AuthServices.fetchAuthToken();

      Uri uri = Uri.parse(
          "${UrlConstants.backendUrlV1}/personal/fetchAll?userId=67dbee7cb848635421854c86");
      http.Response response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Response Else ${response.statusCode}: ${response.body}");
      }
    } catch (error) {
      print("error: $error");
    }
  }
}
