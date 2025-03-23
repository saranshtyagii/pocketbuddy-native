import 'dart:convert';

class UserAuthentication {
  final String usernameOrEmail;
  final String password;
  final String deviceId;
  final String ipAddress;
  final String modelName;
  final String modelVersion;
  final String osVersion;
  final String appVersion;

  UserAuthentication(this.deviceId, this.ipAddress, this.modelName,
      this.modelVersion, this.osVersion, this.appVersion,
      {required this.usernameOrEmail, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "usernameOrEmail": usernameOrEmail,
      "password": password,
      "deviceId": deviceId,
      "ipAddress": ipAddress,
      "modelName": modelName,
      "modelVersion": modelVersion,
      "osVersion": osVersion,
      "appVersion": appVersion
    };
  }

  static String convertToJson(UserAuthentication userData) {
    return jsonEncode(userData.toJson());
  }

  getUsernameOrEmail() {
    return usernameOrEmail;
  }
}
