import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/song_model.dart';

import '../../../../data/model/new-song_model.dart';
part 'current_selected_song_event.dart';
part 'current_selected_song_state.dart';

class CurrentSelectedSongBloc extends Bloc<CurrentSelectedSongEvent, CurrentSelectedSongState> {
  String? _currentSelectedSongName;
  String? _currentSelectedSongFile;
  String? _currentSelectedSongImage;
  String? _currentSelectedSongSingerName;
  int? _currentSelectedSongId;

  String? get currentSelectedSongName => _currentSelectedSongName;
  String? get currentSelectedSongFile => _currentSelectedSongFile;
  String? get currentSelectedSongImage => _currentSelectedSongImage;
  int? get currentSelectedSongId => _currentSelectedSongId;
  String? get currentSelectedSongSingerName => _currentSelectedSongSingerName;

  CurrentSelectedSongBloc() : super(CurrentSelectedSongInitial()) {
    on<SelectSong>((event, emit) {
      emit(LoadingNewSong());
      _currentSelectedSongName = event.songName;
      _currentSelectedSongFile = event.songFile;
      _currentSelectedSongImage = event.songImage;
      _currentSelectedSongId = event.id;
      _currentSelectedSongSingerName = event.songSingerName;

      emit(SelectedSongFetched(songId: event.id, songName: event.songName,
          songFile: event.songFile, songImage: event.songImage, singerName: event.songSingerName));
    });

    on<PlayNextSong>((event, emit) {
      emit(LoadingNewSong());
      final SongDataModel nextSong;
      final index = getCurrentSongIndex(event.songs);
      if (index == event.songs.length - 1) {
        nextSong = event.songs.elementAt(0);
      } else {
        nextSong = event.songs.elementAt(index + 1);
      }
      _currentSelectedSongName = nextSong.name;
      _currentSelectedSongFile = nextSong.fileSource;
      _currentSelectedSongImage = nextSong.imageSource;
      _currentSelectedSongId = nextSong.id;
      _currentSelectedSongSingerName = nextSong.album!.singer!.name;
      emit(SelectedSongFetched(songId: nextSong.id!, songName: nextSong.name!,
          songImage: nextSong.imageSource!, songFile: nextSong.fileSource!,
          singerName: nextSong.album!.singer!.name!));
    });

    on<PlayPreviousSong>((event, emit) {
      emit(LoadingNewSong());
      final SongDataModel previousSong;
      final index = getCurrentSongIndex(event.songs);
      if (index == 0) {
        previousSong = event.songs.last;
      } else {
        previousSong = event.songs.elementAt(index - 1);
      }
      _currentSelectedSongName = previousSong.name;
      _currentSelectedSongFile = previousSong.fileSource;
      _currentSelectedSongImage = previousSong.imageSource;
      _currentSelectedSongId = previousSong.id;
      _currentSelectedSongSingerName = previousSong.album!.singer!.name!;
      emit(SelectedSongFetched(songId: previousSong.id!, songName: previousSong.name!,
          songImage: previousSong.imageSource!, songFile: previousSong.fileSource!,
          singerName: previousSong.album!.singer!.name!));
    });
  }

  getCurrentSongIndex(List<SongDataModel> songs) {
    final currentSongIndex = songs.indexWhere((element) => element.id == _currentSelectedSongId);
    return currentSongIndex;
  }
}
