import 'package:procketbuddy_native/main.dart';

class UserDeatils {
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String username;
  final String email;
  final String mobileNumber;

  UserDeatils({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.username,
    required this.email,
    required this.mobileNumber,
  });

  Future<UserDeatils?> fetchUserDetails() async {
    await storage.ready;
    String jsonResponse = storage.getItem("pocket_buddy_user_details");

    return null;
  }
}
