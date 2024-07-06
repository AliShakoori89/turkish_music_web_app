import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class SongRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  Future<dynamic> getAllMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    List<SongDataModel> allSongs = [];
    final response = await api.get('/api/Music/GetAll', page: "1", count: "111");
    final data = jsonDecode(response.body);
    final List<dynamic> allSongList = data['data'];

    allSongs = allSongList.map((e) => SongDataModel.fromJson(e)).toList();

    return allSongs;
  }

  Future<dynamic> getAllNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    try {
      final response = await api.get(
          '/api/NewMusic/GetAll');
      if (response.statusCode == 200) {
        List<SongDataModel> songs = [];
        final data = jsonDecode(response.body);
        final List<dynamic> songList = data['data'];
        for(int i = 0 ; i < songList.length ; i++){
          songList[i]['fileSource'] = songList[i]['fileSource'].substring(0, 4) + "s" +songList[i]['fileSource'].substring(4, songList[i]['fileSource'].length);
        }

        songs = songList.map((e) => SongDataModel.fromJson(e)).toList();
        return songs;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}