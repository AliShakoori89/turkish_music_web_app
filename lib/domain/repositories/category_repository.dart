import 'dart:convert';
import '../../data/model/category_model.dart';
import '../../data/network/api_base_helper.dart';

class CategoryRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getAllCategory() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Category/GetAll');

    final productJson = json.decode(response.body);
    var allCategory = CategoryModel.fromJson(productJson);
    return allCategory.data;
  }
}