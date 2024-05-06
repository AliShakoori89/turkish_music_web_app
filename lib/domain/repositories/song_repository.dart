import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:turkish_music_app/data/model/get_all_musics_model.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class SongRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  // @override
  // Future<dynamic> getMusic(int id) async {
  //   ApiBaseHelper api = ApiBaseHelper();
  //   final SongModel response = await api.get('/api/Music/GetOneMusic/$id');
  //   print("response.data:                   "+response.data.toString());
  //   return response.data;
  // }

  // @override
  // Future<dynamic> getAllMusic() async {
  //   ApiBaseHelper api = ApiBaseHelper();
  //   final response = await api.get('/api/Music/GetAll', page: "1", count: "111");
  //   final productJson = json.decode(response.body);
  //   print("##################################################productJson:                   "+ productJson.toString());
  //   var AllSongData = GetAllMusicDataModel.fromJson(productJson);
  //   print("response.data:                   ");
  //   print("response.data:                   "+AllSongData.toString());
  //   return response;
  // }

  @override
  Future<dynamic> getAllNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    try {
      final response = await api.get(
          '/api/NewMusic/GetAll');
      print("response.statusCode                    "+response.statusCode.toString());
      if (response.statusCode == 200) {
        List<SongDataModel> songs = [];
        print("response.data                    "+response.body.toString());
        final data = jsonDecode(response.body);
        print("data                              "+data.toString());
        final List<dynamic> songList = data['data'];
        print("songList                            "+songList.toString());
        print(songList[0]['fileSource']);
        for(int i = 0 ; i < songList.length ; i++){
          songList[i]['fileSource'] = songList[i]['fileSource'].substring(0, 4) + "s" +songList[i]['fileSource'].substring(4, songList[i]['fileSource'].length);
        }
        // print("*********************                            "+songDataModel.name.toString());
        // SongDataModel songDataModel = SongDataModel();
        // songDataModel.id = GetAllMusicDataModel().id;
        // songDataModel.name = GetAllMusicDataModel().name;
        // songDataModel.fileSource = GetAllMusicDataModel().fileSource;
        // songDataModel.imageSource = GetAllMusicDataModel().imageSource;
        // songDataModel.minute = GetAllMusicDataModel().minute;
        // songDataModel.second = GetAllMusicDataModel().second;

        songs = songList.map((e) => SongDataModel.fromJson(e)).toList();
        print("songs          *****************                 "+songs[0].fileSource.toString());
        return songs;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}