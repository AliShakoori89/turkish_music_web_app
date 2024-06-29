import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/singer_model.dart';
import '../../data/network/api_base_helper.dart';

class SearchRepository {

final String? apiKey = dotenv.env['map.apikey'];

  @override
  Future<dynamic> getSearchSong(String searchWord) async {

    ApiBaseHelper api = ApiBaseHelper();

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var singer = SingerModel.fromJson(productJson);

    for(int i = 0 ; i < singer.data.length ; i++){
      if(singer.data[i].isBest == true){
        print(singer.data[i].name);
        isBestSinger.add(singer.data[i]);
      }else{
      }
    }
    return isBestSinger;
  }
}