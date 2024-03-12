import 'dart:convert';
import '../../data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class NewMusicRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);
    var newDongData = NewMusicModel.fromJson(productJson);
    return newDongData.data;
  }

}