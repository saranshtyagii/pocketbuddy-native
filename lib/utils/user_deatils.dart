import 'dart:convert';
import 'package:procketbuddy_native/main.dart';

class UserDetails {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String username;
  final String email;
  final String mobileNumber;

  static UserDetails? saveUserDetailsInStorage;

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
      userId: json['userId']?.toString() ?? '',
      userFirstName: json['userFirstName']?.toString() ?? '',
      userLastName: json['userLastName']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      mobileNumber: json['mobileNumber']?.toString() ?? '',
    );
  }

  static Future<UserDetails?> fetchUserDetails() async {
    String? jsonResponse = await storage.read(key: "pocket_buddy_user_details");

    if (jsonResponse == null) return null;

    try {
      Map<String, dynamic> userData = jsonDecode(jsonResponse);
      return UserDetails.fromJson(userData);
    } catch (error) {
      print("Error decoding user details JSON: $error");
      return null;
    }
  }

  static Future<void> saveUserDetails(Map<String, dynamic> userData) async {
    try {
      UserDetails user = UserDetails.fromJson(userData);
      await storage.write(
          key: 'pocket_buddy_user_details', value: jsonEncode(user.toJson()));

      saveUserDetailsInStorage = await fetchUserDetails();
      print("\n---------\n User Details Saved Successfully \n---------");
    } catch (error) {
      print("Error saving user details: $error");
    }
  }
}
