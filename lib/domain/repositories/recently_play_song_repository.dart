import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import '../../data/data_base/data_base.dart';
import '../../data/model/album_model.dart';
import '../../data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class RecentlyPlaySongRepository {

  late final DatabaseHelper helper;

  RecentlyPlaySongRepository() {
    helper = DatabaseHelper();
  }

  Future<List<AlbumDataMusicModel>> getAllSongsRepo() async {

    var recentlyPlayedSong = await helper.getAllRecentlyPlayedSong();

    List<AlbumDataMusicModel> allSong = [];

    if(recentlyPlayedSong.length < 30){
      for(int i = 0 ; i < recentlyPlayedSong.length ; i++){

        print("1111111111111111                         "+recentlyPlayedSong[i].singerName.toString());

        AlbumDataMusicModel albumDataMusicModel = AlbumDataMusicModel(
            id: recentlyPlayedSong[i].id,
            name: recentlyPlayedSong[i].songName,
            singerName: recentlyPlayedSong[i].singerName,
            minute: recentlyPlayedSong[i].audioFileMin,
            second: recentlyPlayedSong[i].audioFileSec,
            albumId: recentlyPlayedSong[i].audioFileAlbumId,
            album: '',
            fileSource: recentlyPlayedSong[i].audioFilePath,
            imageSource: recentlyPlayedSong[i].imageFilePath,
            categories: []
        );
        allSong.add(albumDataMusicModel);
      }
    }else{
      for(int i = 0 ; i < 30 ; i++){

        AlbumDataMusicModel albumDataMusicModel = AlbumDataMusicModel(
            id: recentlyPlayedSong[i].id,
            name: recentlyPlayedSong[i].songName,
            singerName: recentlyPlayedSong[i].singerName,
            minute: recentlyPlayedSong[i].audioFileMin,
            second: recentlyPlayedSong[i].audioFileSec,
            albumId: recentlyPlayedSong[i].audioFileAlbumId,
            album: '',
            fileSource: recentlyPlayedSong[i].audioFilePath,
            imageSource: recentlyPlayedSong[i].imageFilePath,
            categories: []
        );
        allSong.add(albumDataMusicModel);
      }
    }


    return allSong;
  }

  saveRecentlyPlayedSong(SaveSongModel recentlyPlayedSongIdModel) async{
    if (recentlyPlayedSongIdModel.singerName != null) {
      print("****************88 " + recentlyPlayedSongIdModel.singerName.toString());
      return await helper.saveRecentlyPlayedSong(recentlyPlayedSongIdModel);
    } else {
      print("Singer name is null, skipping save.");
    }
  }
}