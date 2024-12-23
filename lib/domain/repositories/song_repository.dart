import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import '../../data/model/album_model.dart';
import '../../data/network/api_base_helper.dart';

class SongRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<dynamic> getAllSongs(String char) async {
    ApiBaseHelper api = ApiBaseHelper();

    try {
      final response = await api.get('/api/Music/GetAll', page: "1", count: "10162", searchChar: char);
      if (response.statusCode == 200) {
        List<SongDataModel> allSongs = [];
        final data = jsonDecode(response.body);
        final List<dynamic> allSongList = data['data'];
        try {
          allSongs = allSongList.map((e) => SongDataModel.fromJson(e)).toList();
        } catch (e) {
          print('Error while parsing songs: $e');
        }
        return allSongs;
      }
    }catch (e) {
      throw e.toString();
    }
  }

  FutureOr<dynamic> getSongByID(int id) async {
    ApiBaseHelper api = ApiBaseHelper();
    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString('accessToken');
      final response = await api.get('/api/Music/GetOneMusic/$id', accessToken: accessToken!);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final song = data['data'];

        SongDataModel song1 = SongDataModel(
          singerName: song['singerName'],
          second: song['second'],
          name: song['name'],
          minute: song['minute'],
          imageSource: song['imageSource'],
          id: song['id'],
          fileSource: song['fileSource'].substring(0, 4) + "s"
              +song['fileSource'].substring(4, song['fileSource'].length),
          albumId: song['albumId']
        );

        AlbumDataMusicModel song2 = AlbumDataMusicModel(
            singerName: song1.singerName,
            second: song1.second,
            name: song1.name,
            minute: song1.minute,
            imageSource: song1.imageSource,
            id: song1.id,
            fileSource: song['fileSource'].substring(0, 4) + "s"
                +song['fileSource'].substring(4, song['fileSource'].length),
            albumId: song1.albumId
        );

        return song2;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}