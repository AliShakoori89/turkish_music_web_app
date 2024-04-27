import 'dart:convert';

import '../../data/network/api_base_helper.dart';

class PlayListRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  addToPlayList(String songName, int musicID) async {
    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "userId": 0,
      "musicId": musicID,
      "apiKey": apiKey
    });

    await api.post('/api/PlayList/AddToPlayList', body);
  }

  @override
  removeFromPlayList(){

  }

}