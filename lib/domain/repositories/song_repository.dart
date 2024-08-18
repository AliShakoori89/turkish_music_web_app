import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class SongRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<dynamic> getAllSongs() async {
    ApiBaseHelper api = ApiBaseHelper();

    try {
      final response = await api.get('/api/Music/GetAll', page: "1", count: "111");
      if (response.statusCode == 200) {
        List<SongDataModel> allSongs = [];
        final data = jsonDecode(response.body);
        final List<dynamic> allSongList = data['data'];
        for(int i = 0 ; i < allSongList.length ; i++){
          allSongList[i]['fileSource'] = allSongList[i]['fileSource'].substring(0, 4) +
              "s" +allSongList[i]['fileSource'].substring(4, allSongList[i]['fileSource'].length);
        }
        allSongs = allSongList.map((e) => SongDataModel.fromJson(e)).toList();
        return allSongs;
      }
    }catch (e) {
      throw e.toString();
    }
  }

  FutureOr<dynamic> getAllNewSongs() async {
    ApiBaseHelper api = ApiBaseHelper();
    try {
      final response = await api.get('/api/NewMusic/GetAll');
      if (response.statusCode == 200) {
        List<SongDataModel> songs = [];
        final data = jsonDecode(response.body);
        final List<dynamic> songList = data['data'];
        for(int i = 0 ; i < songList.length ; i++){
          songList[i]['fileSource'] = songList[i]['fileSource'].substring(0, 4) + "s"
              +songList[i]['fileSource'].substring(4, songList[i]['fileSource'].length);
        }
        songs = songList.map((e) => SongDataModel.fromJson(e)).toList();
        return songs.reversed;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  FutureOr<dynamic> getSongByID(int id) async {
    ApiBaseHelper api = ApiBaseHelper();

    try {
      final response = await api.get('/api/Music/GetOneMusic/$id');
      if (response.statusCode == 200) {
        print("1111111111111111");
        List<SongDataModel> allSongs = [];
        final data = jsonDecode(response.body);
        final List<dynamic> allSongList = data['data'];
        for(int i = 0 ; i < allSongList.length ; i++){
          allSongList[i]['fileSource'] = allSongList[i]['fileSource'].substring(0, 4) +
              "s" +allSongList[i]['fileSource'].substring(4, allSongList[i]['fileSource'].length);
        }
        allSongs = allSongList.map((e) => SongDataModel.fromJson(e)).toList();
        for(int i = 0 ; i < allSongs.length ; i++){
          print(allSongs[i].name);
        }

        return allSongs;
      }
    }catch (e) {
      throw e.toString();
    }
  }
}