import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/get_all_musics_model.dart';
import '../../data/model/singer_model.dart';
import '../../data/network/api_base_helper.dart';

class SearchRepository {

final String? apiKey = dotenv.env['map.apikey'];

  @override
  Future<dynamic> getSearchSong(String searchWord) async {

    ApiBaseHelper api = ApiBaseHelper();

    List<SingerDataModel> searchedSinger = [];
    List<GetAllMusicDataModel> searchedSong = [];

    final response = await api.get('/api/Singer/GetAll');
    final productJson = json.decode(response.body);
    var singer = SingerModel.fromJson(productJson);

    final response1 = await api.get('/api/Music/GetAll', page: "1", count: "111");
    final productJson1 = json.decode(response1.body);
    var allSongData = GetAllMusicDataModel.fromJson(productJson1);


    for(int i = 0 ; i < singer.data.length ; i++){
      if(singer.data[i].name == searchWord){
        print(singer.data[i].name);
        searchedSinger.add(singer.data[i]);
      }else if( allSongData.name == searchWord){
        searchedSong.add(allSongData);
      }
    }
    return searchedSinger;
  }
}