import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/user_model.dart';
import '../../data/network/api_base_helper.dart';

class SignUserRepository {

  FutureOr<String?> requestPublic(String email) async {

    await dotenv.load();
    final String? apiKey = dotenv.get("apiKey");

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email,
      "apiKey": apiKey});

    final response = await api.post("/api/User/registerPublic",body);
    if (response.statusCode == 200) {

      Get.snackbar("Registration", "Registration was successful",
          backgroundColor: const Color(
              0xFF00B01E).withOpacity(0.2));
      return 'sent';
    }
    else {
      Get.snackbar("Registration", "The desired user exists .",
          backgroundColor: const Color(
              0xFFC20808).withOpacity(0.2));

      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      return message;
    }
  }


  firstLogin(String email) async {

    await dotenv.load();
    final String? apiKey = dotenv.get("apiKey");

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({'email': email, "verificationToken": "",
      "apiKey": apiKey});

    final response = await api.post("/api/User/FirstStepLogin", body);

    if (response.statusCode == 200) {
      Get.snackbar("Verification Code","Send verification code successfully .",
          backgroundColor: const Color(
              0xFF00B01E).withOpacity(0.2));
      return true;
    }
    else if (response.statusCode == 401){
      Get.snackbar("Verification Code","OnAuthorize !!",
          backgroundColor: const Color(
              0xFFC20808).withOpacity(0.2));
      return false;
    }
    else if (response.statusCode == 404){
      Get.snackbar("Verification Code","User Not Exist !!",
          backgroundColor: const Color(
              0xFFC20808).withOpacity(0.2));
      return false;
    }
  }

  FutureOr<bool> secondLogin(String email, String verificationToken) async {

    await dotenv.load();
    final String? apiKey = dotenv.get("apiKey");

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email,
      "verificationToken": verificationToken,
      "apiKey": apiKey});
    final response = await api.post("/api/User/SecondStepLogin", body);
    var parsedJson = json.decode(response.body);

    var accessToken = parsedJson['data'];

    if (response.statusCode == 200) {
      await savedAccessTokenValue(accessToken);
      return true;
    }
    else {
      return false;
    }
  }

  FutureOr<UserModel> getCurrentUser() async {
    ApiBaseHelper api = ApiBaseHelper();

    String accessToken = await getAccessTokenValue();

    final response =
    await api.get('/api/User/testAuthorize', accessToken: accessToken);
    final productJson = json.decode(response.body);

    return UserModel.fromJson(productJson);
  }

  saveUserInLocalStorage(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(user.toJson()));
    return true;
  }

  FutureOr<UserModel> getUserInLocalStorage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    UserModel user =
    UserModel.fromJson(jsonDecode(userData!));
    return user;
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