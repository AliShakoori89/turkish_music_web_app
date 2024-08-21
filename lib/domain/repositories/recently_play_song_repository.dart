import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/recently_played_song_Id_model.dart';
import '../../data/data_base/data_base.dart';
import '../../data/model/album_model.dart';
import '../../data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class RecentlyPlaySongRepository {

  late final DatabaseHelper helper;

  RecentlyPlaySongRepository() {
    helper = DatabaseHelper();
  }

  Future<List<AlbumDataMusicModel>> getAllSongsIDRepo() async {

    var recentlyPlayedSongIDs = await helper.getAllRecentlyPlayedSongId();
    ApiBaseHelper api = ApiBaseHelper();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    List<AlbumDataMusicModel> allSong = [];
    for(int i = recentlyPlayedSongIDs.length ; i >= 0 ; i--){
      print(i--);
      print(recentlyPlayedSongIDs[i].id);


      final response = await api.get('/api/Music/GetOneMusic/${recentlyPlayedSongIDs[i].id}', accessToken: accessToken!);
      final productJson = json.decode(response.body);
      SongDataModel song = SongDataModel.fromJson(productJson['data']);

      AlbumDataMusicModel generateSong = AlbumDataMusicModel(
          singerName: song.singerName,
          second: song.second,
          name: song.name,
          minute: song.minute,
          imageSource: song.imageSource,
          id: song.id,
          fileSource: song.fileSource!.substring(0, 4) + "s"
              +song.fileSource!.substring(4, song.fileSource!.length),
          albumId: song.albumId
      );

      print(generateSong.name);
      
      allSong.add(generateSong);
    }
    return allSong;
  }

  addPlayedSongID(RecentlyPlayedSongIdModel recentlyPlayedSongIdModel) async{
    return await helper.saveRecentlyPlayedSongId(recentlyPlayedSongIdModel);
  }
}