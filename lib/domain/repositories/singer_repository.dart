import 'dart:async';
import 'dart:convert';
import '../../data/model/singer_model.dart';
import '../../data/network/api_base_helper.dart';

class SingerRepository {

  final String apiKey = "YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst";


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
    return isBestSinger.reversed.toList();
  }

  Future<dynamic> getAllSinger() async {
    ApiBaseHelper api = ApiBaseHelper();
    List<SingerDataModel> allSinger = [];

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var singer = SingerModel.fromJson(productJson);

    for(int i = 0 ; i < singer.data.length ; i++){
      allSinger.add(singer.data[i]);
    }
    return allSinger;
  }

  Future<dynamic> getAllSingerName() async {
    ApiBaseHelper api = ApiBaseHelper();
    List<String> allSingerName = [];

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var singer = SingerModel.fromJson(productJson);

    for(int i = 0 ; i < singer.data.length ; i++){
      allSingerName.add(singer.data[i].name);
    }
    return allSingerName;
  }
}