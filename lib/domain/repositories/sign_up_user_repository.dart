import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import '../../data/network/api_base_helper.dart';

class SignUpUserRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  FutureOr<String?> requestPublic(String email) async {

    print("2222");

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email,
      // "verificationToken": "",
      "apiKey": apiKey});

    print("body :::::::::::::::::::::       "+body);

    final response = await api.post("/api/User/registerPublic",body);
    if (response.statusCode == 200) {

      print("66666");

      Get.snackbar("Registration", "Registration was successful");

      return 'sent';
    }
    else {

      print("777777");

      Get.snackbar("Registration", "Registration failed !!");

      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      return message;
    }
  }


  FutureOr<bool?> registerUserViaOTPCode(String email) async {
    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({'email': email, "verificationToken": "",
      "apiKey": apiKey});
    final response = await api.post("/api/User/FirstStepLogin", body);
    if (response.statusCode == 200) {
      Get.snackbar("Verification Code","Send verification code successfully");
      return true;
    }
    else {
      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      Get.snackbar("Verification Code","verification code send failed !!");
      return false;
    }
  }

}