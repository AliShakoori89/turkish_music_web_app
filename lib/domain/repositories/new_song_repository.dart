import 'dart:async';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/model/album_model.dart';
import '../../data/model/new-song_model.dart';
import '../../data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class NewSongRepository {

  final cache = DefaultCacheManager();

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<List<AlbumDataMusicModel>> getNewMusic() async {
    // ApiBaseHelper api = ApiBaseHelper();
    // List<AlbumDataMusicModel> allNewMusics = [];
    // final response = await api.get('/api/Music/GetAll', page: "1", count: "900000");
    // print(response.statusCode.toString());
    // print(response.body.toString());
    // print(response.body.length.toString());
    // print(response.body.toString());
    // final productJson = json.decode(response.body);
    // print(productJson["data"][0]["id"].toString());
    // // print("4444444444            "+productJson.length.toString());
    // // var newSongData = SongDataModel.fromJson(productJson);
    // // print("555555555555555555            "+newSongData.toString());
    // for(int i = 0 ; i < response.body.length ; i++){
    //   if(productJson["data"][i]["isNew"] == true){
    //     print(productJson["data"][i]["id"]);
    //     allNewMusics.add(productJson["data"][i]);
    //   }
    // }
    //
    // print("1111111111111          "+allNewMusics.toString());
    //
    //
    // return allNewMusics;

    ApiBaseHelper api = ApiBaseHelper();
    List<AlbumDataMusicModel> allNewMusics = [];

    final response = await api.get('/api/Music/GetAll', page: "1", count: "9000");
    final productJson = json.decode(response.body);
    var newSongData = SongDataModel.fromJson(productJson);

    for(int i = 0 ; i < response.body.length ; i++){
      if(productJson["data"][i]["isNew"] == true){
        print(productJson["data"][i]["id"]);
        allNewMusics.add(productJson["data"][i]);
        print("1111111111111111111111111111111111               "+productJson["data"][i].toString());
      }else{

      }
    }
    return allNewMusics.reversed.toList();
  }



}