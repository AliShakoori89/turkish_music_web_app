import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/new_album_model.dart';
import '../../data/model/singer_model.dart';
import '../../data/network/api_base_helper.dart';

class SingerRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  @override
  Future<dynamic> getFamousSinger() async {

    ApiBaseHelper api = ApiBaseHelper();
    List<SingerDataModel> isBestSinger = [];

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var singer = SingerModel.fromJson(productJson);

    print("getFamousSinger              "+singer.data.toString());

    for(int i = 0 ; i < singer.data.length ; i++){
      if(singer.data[i].isBest == true){
        print(singer.data[i].name);
        isBestSinger.add(singer.data[i]);
      }else{
      }
    }
    return isBestSinger;
  }

  @override
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

  @override
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