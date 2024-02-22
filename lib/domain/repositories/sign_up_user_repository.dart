import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/presentation/ui/login_page.dart';
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


  firstLogin(String email) async {

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({'email': email, "verificationToken": "",
      "apiKey": apiKey});

    final response = await api.post("/api/User/FirstStepLogin", body);

    if (response.statusCode == 200) {
      Get.snackbar("Verification Code","Send verification code successfully .");
      Get.to(InputVerificationCode(email: email));
      return true;
    }
    else if (response.statusCode == 401){
      Get.snackbar("Verification Code","OnAuthorize !!");
      return false;
    }
    else if (response.statusCode == 404){
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

    if (response.statusCode == 200) {
      await savedAccessTokenValue(accessToken);
      Get.snackbar("Check Authentication","Authentication Success...  WellCome");
      return true;
    }
    else {
      Get.snackbar("Check Authentication","The Entered Verification Code Is Invalid !!");
      Get.to(const LoginPage());
      return false;
    }
  }

  Future<UserModel> getCurrentUser() async {
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