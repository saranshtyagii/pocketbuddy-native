import 'dart:convert';

class UserRegister {
  final String userFirstName;
  final String userLastName;
  final String username;
  final String email;
  final String mobileNumber;
  final String password;

  UserRegister({
    required this.userFirstName,
    required this.userLastName,
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "userFirstName": userFirstName,
      "userLastName": userLastName,
      "username": username,
      "email": email,
      "mobileNumber": mobileNumber,
      "password": password,
    };
  }

  static String convertToJson(UserRegister userData) {
    return jsonEncode(userData.toJson());
  }
}
