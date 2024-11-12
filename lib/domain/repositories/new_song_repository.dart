import 'dart:async';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import '../../data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class NewSongRepository {

  final cache = DefaultCacheManager();

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<List<SongDataModel>> getNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    List<SongDataModel> allNewMusics = [];

    final response = await api.get('/api/Music/GetAll', page: "1", count: "9524");
    final productJson = json.decode(response.body);

    if (productJson["data"] is List) {
      print("Data length: ${productJson["data"].length}");

      for (var item in productJson["data"]) {
        print("item                  "+item["isNew"].toString());
        if (item["isNew"] == true) {
          final newSong = NewAlbumDataModel.fromJson(item);
          SongDataModel songDataModel = SongDataModel(
            id: newSong.id,
            imageSource: newSong.imageSource,
            name: newSong.name,
            singerName: newSong.singer!.name,
          );
          allNewMusics.add(songDataModel);
        }
      }
    } else {
      // print("Data is not a list or is missing.");
    }

    // print("Final count of new music items: ${allNewMusics.length}");
    return allNewMusics;
  }

}