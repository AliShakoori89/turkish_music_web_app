import 'dart:async';
import 'dart:convert';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import '../../data/model/singer_model.dart';
import '../../data/network/api_base_helper.dart';

class MusicRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);
    var newDongData = NewMusicModel.fromJson(productJson);
    return newDongData.data;
  }

  @override
  Future<dynamic> getFamousArtist() async {

    ApiBaseHelper api = ApiBaseHelper();
    List<SingerDataModel> isBestArtist = [];

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var artist = SingerModel.fromJson(productJson);

    for(int i = 0 ; i < artist.data.length - 1 ; i++){
      if(artist.data[i].isBest == true){
        isBestArtist.add(artist.data[i]);
      }else{
      }
    }
    return isBestArtist;
  }
}