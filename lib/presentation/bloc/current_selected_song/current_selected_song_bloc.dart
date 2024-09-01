import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';

part 'current_selected_song_event.dart';
part 'current_selected_song_state.dart';

class CurrentSelectedSongBloc extends Bloc<CurrentSelectedSongEvent, CurrentSelectedSongState> {
  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  CurrentSelectedSongBloc() : super(CurrentSelectedSongInitialState()) {
    // Event Handlers
    on<SelectSongEvent>(_onSelectSong);
    on<PlayNextSongEvent>(_onPlayNextSong);
    on<PlayPreviousSongEvent>(_onPlayPreviousSong);
    on<SelectedSongCompleteEvent>(_onSelectedSongCompleteState);
    on<CurrentSelectedSongErrorEvent>(_onCurrentSelectedSongErrorEvent);
  }

  // Handlers for each event
  Future<void> _onSelectSong(SelectSongEvent event, Emitter<CurrentSelectedSongState> emit) async {
    emit(LoadingNewSongState());
    _currentSelectedSong = event.songModel;
    emit(SelectedSongFetchedState(songModel: event.songModel));
  }

  Future<void> _onPlayNextSong(PlayNextSongEvent event, Emitter<CurrentSelectedSongState> emit) async {
    emit(LoadingNewSongState());

    try {
      final nextSong = _getNextSong(event.songs);
      _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);

      await _saveCurrentSongData(_currentSelectedSong!);
      emit(SelectedSongFetchedState(songModel: _currentSelectedSong!));
    } catch (e) {
      // Handle error if necessary
      emit(CurrentSelectedSongErrorState("Failed to load the next song."));
    }
  }

  Future<void> _onPlayPreviousSong(PlayPreviousSongEvent event, Emitter<CurrentSelectedSongState> emit) async {
    emit(LoadingNewSongState());

    try {
      final previousSong = _getPreviousSong(event.songs);
      _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(previousSong);

      await _saveCurrentSongData(_currentSelectedSong!);
      emit(SelectedSongFetchedState(songModel: _currentSelectedSong!));
    } catch (e) {
      // Handle error if necessary
      emit(CurrentSelectedSongErrorState("Failed to load the previous song."));
    }
  }

  Future<void> _onSelectedSongCompleteState(SelectedSongCompleteEvent event, Emitter<CurrentSelectedSongState> emit) async {
    emit(SelectedSongCompletedState(songModel: event.songModel));
  }

  Future<void> _onCurrentSelectedSongErrorEvent(CurrentSelectedSongErrorEvent event, Emitter<CurrentSelectedSongState> emit) async {
    emit(CurrentSelectedSongErrorState(event.errorMessage));
  }

  // Helper Methods

  AlbumDataMusicModel _getNextSong(List<AlbumDataMusicModel> songs) {
    final index = _getCurrentSongIndex(songs);
    return (index == songs.length - 1) ? songs.first : songs[index + 1];
  }

  AlbumDataMusicModel _getPreviousSong(List<AlbumDataMusicModel> songs) {
    final index = _getCurrentSongIndex(songs);
    return (index == 0) ? songs.last : songs[index - 1];
  }

  int _getCurrentSongIndex(List<AlbumDataMusicModel> songs) {
    return songs.indexWhere((element) => element.id == _currentSelectedSong?.id);
  }

  SongDataModel _mapAlbumDataMusicModelToSongDataModel(AlbumDataMusicModel song) {
    return SongDataModel(
      id: song.id,
      name: song.name,
      imageSource: song.imageSource,
      fileSource: song.fileSource!.replaceFirst('http', 'https'),
      singerName: song.singerName,
      minute: song.minute,
      second: song.second,
      albumId: song.albumId,
    );
  }

  Future<void> _saveCurrentSongData(SongDataModel songDataModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('songID', songDataModel.id!);
    await prefs.setInt('albumID', songDataModel.albumId!);
  }
}
