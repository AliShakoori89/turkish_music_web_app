import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/register_model.dart';
import 'package:turkish_music_app/data/model/user_exist_model.dart';
import '../../data/model/login_model.dart';
import '../../data/model/user_model.dart';
import '../../data/network/api_base_helper.dart';

class UserRepository {

  FutureOr<String?> requestPublic(String email) async {

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email});

    final response = await api.post("/api/User/registerPublic",body);
    var responseModel = RegisterModel.fromJson(jsonDecode(response.body));
    if (responseModel.success!) {
      var accessToken = responseModel.data;
      await savedAccessTokenValue(accessToken!);
      return 'success';
    }
    else {
      var parsedJson = RegisterModel.fromJson(jsonDecode(response.body));
      return parsedJson.message;
    }
  }


  FutureOr<String?> firstStepLogin(String email) async {

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      'email': email,
      "verificationToken": 'string'});

    final response = await api.post("/api/User/FirstStepLogin", body);
    var responseModel = LoginModel.fromJson(jsonDecode(response.body));
    if (responseModel.success!) {
      return 'success';
    }
    else {
      var parsedJson = RegisterModel.fromJson(jsonDecode(response.body));
      return parsedJson.message;
    }
  }

  Future<Map<String, dynamic>> userExist(String email) async{

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({'email': email, "isAdmin": false});
    final response = await api.post("/api/User/registerPublic", body);
    var responseModel = UserExistModel.fromJson(jsonDecode(response.body));
    return {"message": responseModel.message!, "statusCode": responseModel.success};
  }

  FutureOr<String?> secondLogin(String email, String verificationToken) async {

    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      'email': email,
      "verificationToken": verificationToken});
    final response = await api.post("/api/User/SecondStepLogin", body);
    var responseModel = RegisterModel.fromJson(jsonDecode(response.body));

    if (responseModel.success!) {
      var accessToken = responseModel.data;
      await savedAccessTokenValue(accessToken!);
      return 'success';
    }
    else {
      var parsedJson = RegisterModel.fromJson(jsonDecode(response.body));
      return parsedJson.message;
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
    print(accessToken);
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