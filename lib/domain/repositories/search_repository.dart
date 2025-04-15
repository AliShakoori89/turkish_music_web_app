import 'dart:async';
import 'dart:convert';
import '../../data/model/get_all_musics_model.dart';
import '../../data/network/api_base_helper.dart';

class SearchRepository {

  final String apiKey = "YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst";


FutureOr<dynamic> getSearchSong(String searchWord) async {

    ApiBaseHelper api = ApiBaseHelper();

    final response1 = await api.get('/api/Music/GetAll', page: "1", count: "111", searchChar: "$searchWord");
    final productJson1 = json.decode(response1.body);
    var allSongData = GetAllMusicDataModel.fromJson(productJson1);
  }
}