import 'package:turkish_music_app/data/model/recently_played_song_Id_model.dart';
import '../../data/data_base/data_base.dart';

class RecentlyPlaySongRepository {

  late final DatabaseHelper helper;

  RecentlyPlaySongRepository() {
    helper = DatabaseHelper();
  }

  Future<List<RecentlyPlayedSongIdModel>> getAllSongsIDRepo() async {
    return await helper.getAllRecentlyPlayedSongId();
  }

  addPlayedSongID(RecentlyPlayedSongIdModel recentlyPlayedSongIdModel) async{
    return await helper.saveRecentlyPlayedSongId(recentlyPlayedSongIdModel);
  }
}