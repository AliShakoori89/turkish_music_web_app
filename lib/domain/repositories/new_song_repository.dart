import 'dart:async';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/model/album_model.dart';
import '../../data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class NewSongRepository {

  final cache = DefaultCacheManager();

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<List<AlbumDataMusicModel>> getNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    List<AlbumDataMusicModel> allNewMusics = [];
    final response = await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);
    var newSongData = NewMusicModel.fromJson(productJson);

    for(int i = 0 ; i < 4 ; i++){
      AlbumDataMusicModel albumDataMusicModel = AlbumDataMusicModel(
        second: newSongData.data[i].second,
        minute: newSongData.data[i].minute,
        imageSource: newSongData.data[i].imageSource,
        fileSource: newSongData.data[i].fileSource,
        singerName: newSongData.data[i].singer.name,
        name: newSongData.data[i].name,
        id: newSongData.data[i].id,
      );
      print("@@@@@@@@@@                "+newSongData.data[i].imageSource);
      allNewMusics.add(albumDataMusicModel);
    }


    return allNewMusics;
  }

}