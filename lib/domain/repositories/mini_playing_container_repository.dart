import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/miniplayer_model.dart';

class MiniPlayerRepo{
  static final MiniPlayerRepo _miniPlayer = MiniPlayerRepo._internal();
  factory MiniPlayerRepo(){
    return _miniPlayer;
  }

  MiniPlayerRepo._internal();

  final StreamController<bool> _miniPlayerController = StreamController<bool>();

  Stream<bool> getMiniPlayerStream() => _miniPlayerController.stream;

  MiniPlayerModel? song;

  MiniPlayerModel getMiniPlayerSong() => song!;

  saveToMiniPlayer(MiniPlayerModel selectSong){
    song?.songID = selectSong.songID;
    song?.songName = selectSong.songName;
    song?.songsSingerName = selectSong.songsSingerName;
    song?.songImagePath = selectSong.songImagePath;
    song?.songFilePath = selectSong.songFilePath;
    song?.songList = selectSong.songList;

    song = selectSong;

    _miniPlayerController.sink.add(true);
  }
}