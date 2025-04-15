import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/user_model.dart';
import '../../data/network/api_base_helper.dart';

class UserRepository {

  FutureOr<String?> requestPublic(String email) async {

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email});

    final response = await api.post("/api/User/registerPublic",body);
    if (response.statusCode == 200) {
      return 'sent';
    }
    else {
      var parsedJson = json.decode(response.body);
      var message = parsedJson['message'];
      return message;
    }
  }


  firstLogin(String email) async {

    final String apiKey = "YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst";

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({'email': email, "verificationToken": apiKey});
    final response = await api.post("/api/User/FirstStepLogin", body);
    var responseData = jsonDecode(response.body);
    print("Response message: ${responseData['message']}");

    if (response.statusCode == 200) {
      return true;
    }
    else if (response.statusCode == 401){
      return false;
    }
    else if (response.statusCode == 404){
      return false;
    }
  }

  Future<String> userExist(String email) async{

    final String apiKey = "YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst";


    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({'email': email, "verificationToken": apiKey});
    final response = await api.post("/api/User/FirstStepLogin", body);
    var responseData = jsonDecode(response.body);
    print("Response message: ${responseData['message']}");

    return responseData['message'];
  }

  FutureOr<bool> secondLogin(String email, String verificationToken) async {

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email,
      "verificationToken": verificationToken});
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final response = await api.get('/api/User/testAuthorize', accessToken: accessToken!);
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
    UserModel user = UserModel.fromJson(jsonDecode(userData!));
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
    return true;
  }
}