import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/category_model.dart';
import '../../data/network/api_base_helper.dart';

class CategoryRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<List<CategoryDataModel>> getAllCategory() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Category/GetAll');
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final categoryModel = CategoryModel.fromJson(jsonResponse);
      return categoryModel.data!;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  FutureOr<CategoryDataModel> getCategorySongs(int categoryID) async {
    print("categoryID            "+categoryID.toString());
    ApiBaseHelper api = ApiBaseHelper();
    var body = jsonEncode({
      "apiKey": apiKey
    });

    String accessToken = await getAccessTokenValue();
    final response = await api.get('/api/Category/GetOneCategory/$categoryID', accessToken: accessToken);
    print(response.statusCode);
    print("res body :            "+response.body.toString());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("jsonResponse :            "+jsonResponse["data"].toString());
      final categoryModel = CategoryDataModel.fromJson(jsonResponse["data"]);
      print("categoryModel.data! :            "+categoryModel.toString());
      return categoryModel;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  getAccessTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }
}