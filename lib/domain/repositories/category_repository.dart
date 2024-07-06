import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/category_model.dart';
import '../../data/network/api_base_helper.dart';

class CategoryRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  Future<dynamic> getAllCategory() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Category/GetAll');

    final productJson = json.decode(response.body);
    var allCategory = CategoryModel.fromJson(productJson);
    return allCategory.data;
  }
}