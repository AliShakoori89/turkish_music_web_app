import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/model/album_model.dart';
import '../../../../data/model/song_model.dart';

part 'current_selected_song_event.dart';
part 'current_selected_song_state.dart';

class CurrentSelectedSongBloc extends Bloc<CurrentSelectedSongEvent, CurrentSelectedSongState> {
  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  CurrentSelectedSongBloc() : super(CurrentSelectedSongInitial()) {


    on<SelectSong>((event, emit) {
      emit(LoadingNewSong());
      _currentSelectedSong = event.songModel;
      emit(SelectedSongFetched(songModel: event.songModel));
    });

    on<PlayNextSong>((event, emit) async{
      SongDataModel songDataModel;
      emit(LoadingNewSong());
      final AlbumDataMusicModel nextSong;
      final index = getCurrentSongIndex(event.songs);
      if (index == event.songs.length - 1) {
        nextSong = event.songs.elementAt(0);
        songDataModel = SongDataModel(
          id : nextSong.id,
          name: nextSong.name,
          imageSource: nextSong.imageSource,
          fileSource: nextSong.fileSource!.substring(0, 4)
              + "s"
              + nextSong.fileSource!.substring(4, nextSong.fileSource!.length),
          singerName: nextSong.singerName,
          minute: nextSong.minute,
          second: nextSong.second,
          albumId: nextSong.albumId,
        );
      } else {
        nextSong = event.songs.elementAt(index + 1);
        songDataModel = SongDataModel(
          id : nextSong.id,
          name: nextSong.name,
          imageSource: nextSong.imageSource,
          fileSource: nextSong.fileSource!.substring(0, 4)
              + "s"
              + nextSong.fileSource!.substring(4, nextSong.fileSource!.length),
          singerName: nextSong.singerName,
          minute: nextSong.minute,
          second: nextSong.second,
          albumId: nextSong.albumId,
        );
      }

      _currentSelectedSong = songDataModel;
      await writeMiniPlayingRequirement(songDataModel.id!, songDataModel.albumId!);
      emit(SelectedSongFetched(songModel: songDataModel));
    });

    on<PlayPreviousSong>((event, emit) async{
      SongDataModel songDataModel;
      emit(LoadingNewSong());
      final AlbumDataMusicModel previousSong;
      final index = getCurrentSongIndex(event.songs);
      if (index == 0) {
        previousSong = event.songs.last;
        songDataModel = SongDataModel(
          id : previousSong.id,
          name: previousSong.name,
          imageSource: previousSong.imageSource,
          fileSource: previousSong.fileSource!.substring(0, 4)
              + "s"
              + previousSong.fileSource!.substring(4, previousSong.fileSource!.length),
          singerName: previousSong.singerName,
          minute: previousSong.minute,
          second: previousSong.second,
          albumId: previousSong.albumId,
        );
      } else {
        previousSong = event.songs.elementAt(index - 1);
        songDataModel = SongDataModel(
          id : previousSong.id,
          name: previousSong.name,
          imageSource: previousSong.imageSource,
          fileSource: previousSong.fileSource!.substring(0, 4)
              + "s"
              + previousSong.fileSource!.substring(4, previousSong.fileSource!.length),
          singerName: previousSong.singerName,
          minute: previousSong.minute,
          second: previousSong.second,
          albumId: previousSong.albumId,
        );
      }
      _currentSelectedSong = songDataModel;
      await writeMiniPlayingRequirement(songDataModel.id!, songDataModel.albumId!);
      emit(SelectedSongFetched(songModel: songDataModel));

    });
  }

  getCurrentSongIndex(List<AlbumDataMusicModel> songs) {
    print("_currentSelectedSong                                 "+_currentSelectedSong!.id.toString());
    final currentSongIndex = songs.indexWhere((element) => element.id == _currentSelectedSong?.id);
    return currentSongIndex;
  }

  writeMiniPlayingRequirement(int songID, int albumID) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("writeMiniPlayingRequirement      "+songID.toString());
    print("writeMiniPlayingRequirement      "+albumID.toString());
    await prefs.setInt('songID', songID);
    await prefs.setInt('albumID', albumID);
  }
}
