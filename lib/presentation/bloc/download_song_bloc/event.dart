import 'package:turkish_music_app/data/model/save_song_model.dart';

abstract class DownloadSongEvent {
  List<Object> get props => [];
}

class GetAllDownloadSongEvent extends DownloadSongEvent{}


