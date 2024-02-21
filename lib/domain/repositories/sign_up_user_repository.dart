import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/presentation/ui/login_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';

import '../../data/model/user_model.dart';
import '../../data/network/api_base_helper.dart';
import '../../presentation/ui/input_verification_code.dart';

class SignUserRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  FutureOr<String?> requestPublic(String email) async {
    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email,
      // "verificationToken": "",
      "apiKey": apiKey});

    final response = await api.post("/api/User/registerPublic",body);
    if (response.statusCode == 200) {

      Get.snackbar("Registration", "Registration was successful");
      return 'sent';
    }
    else {
      Get.snackbar("Registration", "The desired user exists .");

      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      return message;
    }
  }


  FutureOr<bool?> firstLogin(String email) async {

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({'email': email, "verificationToken": "",
      "apiKey": apiKey});

    final response = await api.post("/api/User/FirstStepLogin", body);

    print("firstLogin");

    if (response.statusCode == 200) {
      Get.snackbar("Verification Code","Send verification code successfully .");
      Get.to(InputVerificationCode(email: email));
      return true;
    }
    else if (response.statusCode == 401){
      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      Get.snackbar("Verification Code","OnAuthorize !!");
      return false;
    }
    else if (response.statusCode == 404){
      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      Get.snackbar("Verification Code","User Not Exist !!");
      return false;
    }
  }

  FutureOr<bool?> secondLogin(String email, String verificationToken) async {
    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({'email': email, "verificationToken": verificationToken,
      "apiKey": apiKey});

    final response = await api.post("/api/User/SecondStepLogin", body);
    var parsedJson = json.decode(response.body);

    var accessToken = parsedJson['data'];

    print("555555555555555555555555555555                     "+accessToken);
    if (response.statusCode == 200) {
      await savedAccessTokenValue(accessToken);
      Get.snackbar("Check Authentication","Authentication Success...  WellCome");

      // Get.to(MainPage(user: user));
      return true;
    }
    else {
      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      Get.snackbar("Check Authentication","The Entered Verification Code Is Invalid !!");
      Get.to(const LoginPage());
      return false;
    }
  }

  Future<UserModel> getCurrentUser() async {
    ApiBaseHelper api = ApiBaseHelper();
    final queryParameters = {
      'apiKey': apiKey
    };
    String accessToken = await getAccessTokenValue();

    print("#########################################           ");
    final response =
    await api.get('/api/User/testAuthorize/', accessToken: accessToken, query: apiKey);
    final productJson = json.decode(response.body);

    print("666666666666666666666666666666                         "+response.body);
    // print("get current user                         "+productJson);
    return UserModel.fromJson(productJson);
  }

  Future<bool> saveUserInLocalStorage(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(user.toJson()));
    return true;
  }

  savedAccessTokenValue(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', accessToken);
  }

  getAccessTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  removeAccessTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("accessToken");
  }

}