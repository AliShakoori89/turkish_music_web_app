import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/recently_played_song_Id_model.dart';
import '../../data/data_base/data_base.dart';
import '../../data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class RecentlyPlaySongRepository {

  late final DatabaseHelper helper;

  RecentlyPlaySongRepository() {
    helper = DatabaseHelper();
  }

  Future<List<SongDataModel>> getAllSongsIDRepo() async {

    var recentlyPlayedSongIDs = await helper.getAllRecentlyPlayedSongId();
    ApiBaseHelper api = ApiBaseHelper();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    List<SongDataModel> allSong = [];
    for(int i = 0 ; i < recentlyPlayedSongIDs.length ; i++){
      final response = await api.get('/api/Music/GetOneMusic/${recentlyPlayedSongIDs[i].id}', accessToken: accessToken!);
      final productJson = json.decode(response.body);
      SongDataModel song = SongDataModel.fromJson(productJson['data']);
      allSong.add(song);
    }
    return allSong;
  }

  addPlayedSongID(RecentlyPlayedSongIdModel recentlyPlayedSongIdModel) async{
    return await helper.saveRecentlyPlayedSongId(recentlyPlayedSongIdModel);
  }
}