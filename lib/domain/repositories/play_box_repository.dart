import 'dart:convert';

import '../../data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class PlayBoxRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getPlayBox(String songName) async {
    ApiBaseHelper api = ApiBaseHelper();
    List<NewSongDataModel> renewSongData =  [];
    final response = await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);
    var newSongData = NewMusicModel.fromJson(productJson);

    for(int i=0; i < newSongData.data.length; i++){
      if(newSongData.data[i].name != songName){
        renewSongData.add(newSongData.data[i]);
      }
    }
    return renewSongData;
  }
}