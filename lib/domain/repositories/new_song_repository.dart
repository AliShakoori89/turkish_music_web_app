import 'dart:async';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class NewSongRepository {

  final cache = DefaultCacheManager();

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<List<NewSongDataModel>> getNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    List<NewSongDataModel> list = [];
    final response = await api.get('/api/Music/GetNewMusics');
    final productJson = json.decode(response.body);
    var newSongModel = NewSongModel.fromJson(productJson);
    for(int i = newSongModel.data!.length-4; i < newSongModel.data!.length; i++){
      list.add(newSongModel.data![i]);
    }
    return list;
  }

  FutureOr<List<NewSongDataModel>> getAllNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    // List<NewSongDataModel> list = [];
    final response = await api.get('/api/Music/GetNewMusics');
    final productJson = json.decode(response.body);
    var newSongModel = NewSongModel.fromJson(productJson);
    print(newSongModel.data!.length);
    return newSongModel.data!;
  }

}