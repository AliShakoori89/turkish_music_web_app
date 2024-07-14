import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class SongRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  Future<dynamic> getAllMusic() async {
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
        return allSongs.reversed;
      }
    }catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> getAllNewMusic() async {
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

  Future<dynamic> getAlbumAllSongs(int id) async {
    ApiBaseHelper api = ApiBaseHelper();
    try {
      final response = await api.get('/api/Music/GetAll', page: "1", count: "111");
      if (response.statusCode == 200) {
        List<SongDataModel> allSongs = [];
        List<dynamic> albumSongs = [];
        final data = jsonDecode(response.body);
        final List<dynamic> allSongList = data['data'];
        for(int i = 0 ; i < allSongList.length ; i++){
          if(allSongList[i]['albumId'] == id){
            albumSongs.add(allSongList[i]);
          }
        }
        for(int i = 0 ; i < albumSongs.length ; i++){
          albumSongs[i]['fileSource'] = albumSongs[i]['fileSource'].substring(0, 4) +
              "s" +albumSongs[i]['fileSource'].substring(4, albumSongs[i]['fileSource'].length);
        }
        allSongs = albumSongs.map((e) => SongDataModel.fromJson(e)).toList();
        return allSongs;
      }
    }catch (e) {
      throw e.toString();
    }
  }
}