import 'dart:convert';
import '../../data/model/new_album_model.dart';
import '../../data/model/singer_model.dart';
import '../../data/network/api_base_helper.dart';

class SingerRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getFamousSinger() async {

    ApiBaseHelper api = ApiBaseHelper();
    List<SingerDataModel> isBestSinger = [];

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var singer = SingerModel.fromJson(productJson);

    for(int i = 0 ; i < singer.data.length ; i++){
      if(singer.data[i].isBest == true){
        isBestSinger.add(singer.data[i]);
      }else{
      }
    }
    return isBestSinger;
  }

  @override
  Future<dynamic> getSinger() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Album/GetNewAlbums');
    final productJson = json.decode(response.body);
    var newDongData = NewAlbumModel.fromJson(productJson);
    return newDongData.data;
  }
}