import 'dart:convert';
import 'package:procketbuddy_native/main.dart';

class UserDetails {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String username;
  final String email;
  final String mobileNumber;

  static UserDetails? saveUserDetailsInStorage; // ✅ Remove 'late'

  UserDetails({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.username,
    required this.email,
    required this.mobileNumber,
  });

  // Convert UserDetails object to JSON
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

  // Convert JSON to UserDetails object
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

  // Fetch user details from local storage
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

  // Save user details to local storage
  static Future<void> saveUserDetails(Map<String, String> userData) async {
    try {
      print("User Details Map to save: $userData");
      storage.write(
          key: "pocket_buddy_user_details", value: jsonEncode(userData));

      // Fetch & Store in Static Variable for Future Use
      saveUserDetailsInStorage = await fetchUserDetails();
    } catch (error) {
      print("Error saving user details: $error");
    }
  }
}
