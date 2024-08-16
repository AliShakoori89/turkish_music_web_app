import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/state.dart';
import '../../../data/model/song_model.dart';
import 'event.dart';

class SongBloc extends Bloc<SongEvent, SongState> {

  SongRepository songRepo = SongRepository();

  SongBloc(this.songRepo) : super(
      SongState.initial()){
    on<FetchNewSongs>(_mapFetchNewSongsEventToState);
    on<FetchAllSongs>(_mapFetchAllSongsEventToState);
    on<FetchAlbumSongs>(_mapFetchAlbumSongsEventToState);
  }

  void _mapFetchNewSongsEventToState(
      FetchNewSongs event, Emitter<SongState> emit) async {
    try {
      emit(state.copyWith(status: SongStatus.loading));
      final List<SongDataModel> newSongs = [];
      final songsList = await songRepo.getAllNewSongs();
      newSongs.addAll(songsList);

      emit(
        state.copyWith(
            status: SongStatus.success,
            newSongList: newSongs
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SongStatus.error));
    }
  }

  void _mapFetchAllSongsEventToState(
      FetchAllSongs event, Emitter<SongState> emit) async {
    try {
      emit(state.copyWith(status: SongStatus.loading));
      final List<SongDataModel> allSongs = [];
      final List<SongDataModel> songsList = await songRepo.getAllSongs();
      allSongs.addAll(songsList);

      emit(
        state.copyWith(
            status: SongStatus.success,
            allSongList: allSongs
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SongStatus.error));
    }
  }

  void _mapFetchAlbumSongsEventToState(
      FetchAlbumSongs event, Emitter<SongState> emit) async {
    try {
      emit(state.copyWith(status: SongStatus.loading));

      final List<SongDataModel> albumSongs = [];
      final List<SongDataModel> songsList = await songRepo.getAlbumAllSongs(event.id);
      albumSongs.addAll(songsList);

      emit(
        state.copyWith(
          status: SongStatus.success,
          albumSongList: albumSongs,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SongStatus.error));
    }
  }
}