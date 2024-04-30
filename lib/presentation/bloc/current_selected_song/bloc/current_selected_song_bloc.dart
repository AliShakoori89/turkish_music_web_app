import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    on<PlayNextSong>((event, emit) {
      emit(LoadingNewSong());
      final SongDataModel nextSong;
      final index = getCurrentSongIndex(event.songs);
      if (index == event.songs.length - 1) {
        nextSong = event.songs.elementAt(0);
      } else {
        nextSong = event.songs.elementAt(index + 1);
      }
      _currentSelectedSong = nextSong;
      emit(SelectedSongFetched(songModel: nextSong));
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
      _currentSelectedSong = previousSong;
      emit(SelectedSongFetched(songModel: previousSong));
    });
  }

  getCurrentSongIndex(List<SongDataModel> songs) {
    final currentSongIndex = songs.indexWhere((element) => element.id == _currentSelectedSong?.id);
    return currentSongIndex;
  }
}
