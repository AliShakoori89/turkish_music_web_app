import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/data/model/song_model.dart';

class SearchItem {
  final AlbumDataModel? album;
  final SongDataModel? song;

  SearchItem({this.album, this.song});
}