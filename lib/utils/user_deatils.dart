import 'dart:convert';
import 'package:procketbuddy_native/main.dart';

class UserDetails {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String username;
  final String email;
  final String mobileNumber;

  UserDetails({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.username,
    required this.email,
    required this.mobileNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'username': username,
      'email': email,
      'mobileNumber': mobileNumber,
    };
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userId: json['userId'] ?? '',
      userFirstName: json['userFirstName'] ?? '',
      userLastName: json['userLastName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
    );
  }

  static Future<UserDetails?> fetchUserDetails() async {
    await storage.ready;
    String? jsonResponse = storage.getItem("pocket_buddy_user_details");

    if (jsonResponse == null) return null;

    try {
      Map<String, dynamic> userData = jsonDecode(jsonResponse);
      return UserDetails.fromJson(userData);
    } catch (error) {
      print("Error decoding user details JSON: $error");
      return null;
    }
  }

  static Future<void> saveUserDetails(Map<String, String> userData) async {
    await storage.ready;
    try {
      storage.setItem("pocket_buddy_user_details", userData);
    } catch (error) {
      print("Error saving user details: $error");
    }
  }
}
