import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/state.dart';
import '../../../data/model/song_model.dart';
import 'event.dart';

class SongBloc extends Bloc<SongEvent, SongState> {

  SongRepository songRepo = SongRepository();

  SongBloc(this.songRepo) : super(
      SongState.initial()){
    on<FetchNewSongsEvent>(_mapFetchNewSongsEventToState);
    on<FetchAllSongsEvent>(_mapFetchAllSongsEventToState);
    on<FetchSongEvent>(_mapFetchSongEventToState);
  }

  void _mapFetchNewSongsEventToState(
      FetchNewSongsEvent event, Emitter<SongState> emit) async {
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
      FetchAllSongsEvent event, Emitter<SongState> emit) async {
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

  void _mapFetchSongEventToState(
      FetchSongEvent event, Emitter<SongState> emit) async {
    try {
      emit(state.copyWith(status: SongStatus.loading));

      AlbumDataMusicModel song = await songRepo.getSongByID(event.songID);
      emit(
        state.copyWith(
            status: SongStatus.success,
            song: song
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SongStatus.error));
    }
  }
}