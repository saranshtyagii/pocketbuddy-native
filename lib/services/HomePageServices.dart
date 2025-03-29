import 'package:http/http.dart' as http;
import 'package:procketbuddy_native/constants/Url_Constants.dart';
import 'package:procketbuddy_native/services/Auth_Services.dart';
import 'package:procketbuddy_native/utils/user_deatils.dart';

class Homepageservices {
  _loadHomeScreen() {}

  addExpense(String screen, String decs, String amount) {
    print("Hit from the $screen");
  }

  Future<http.Response?> fetchUserPersonalExpense() async {
    try {
      String? token = await AuthServices.fetchAuthToken();
      String userId = UserDetails.saveUserDetailsInStorage!.userId;
      print("________________________");
      print("Current user Id: $userId");
      print("________________________");
      Uri uri = Uri.parse(
          "${UrlConstants.backendUrlV1}/personal/fetchAll?userId=$userId");
      http.Response response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        return response;
      }
    } catch (error) {
      print("error: $error");
    }
    return null;
  }
}
