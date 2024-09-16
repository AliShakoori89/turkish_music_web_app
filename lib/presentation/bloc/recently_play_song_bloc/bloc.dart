import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import 'package:turkish_music_app/domain/repositories/recently_play_song_repository.dart';
import 'package:turkish_music_app/presentation/bloc/recently_play_song_bloc/state.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import 'event.dart';

class RecentlyPlaySongBloc extends Bloc<RecentlyPlaySongEvent, RecentlyPlaySongState> {

  RecentlyPlaySongRepository recentlyPlaySongRepository = RecentlyPlaySongRepository();

  RecentlyPlaySongBloc(this.recentlyPlaySongRepository) : super(
      RecentlyPlaySongState.initial()){
    on<GetAllPlayedSongsEvent>(_mapGetAllSongsEventToState);
    on<SavePlayedSongIDToRecentlyPlayedEvent>(_mapSavePlaySongIDEventToState);
  }

  void _mapGetAllSongsEventToState(
      GetAllPlayedSongsEvent event, Emitter<RecentlyPlaySongState> emit) async {
    try {
      emit(state.copyWith(status: RecentlyPlaySongStatus.loading));

      List<AlbumDataMusicModel> allRecentlySongs = await recentlyPlaySongRepository.getAllSongsRepo();

      emit(
        state.copyWith(
          status: RecentlyPlaySongStatus.success,
          allRecentlySongs: allRecentlySongs
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RecentlyPlaySongStatus.error));
    }
  }

  void _mapSavePlaySongIDEventToState(
      SavePlayedSongIDToRecentlyPlayedEvent event, Emitter<RecentlyPlaySongState> emit) async {
    try {
      emit(state.copyWith(status: RecentlyPlaySongStatus.loading));

      await recentlyPlaySongRepository.saveRecentlyPlayedSong(event.recentlyPlayedSongIdModel);

      emit(
        state.copyWith(
          status: RecentlyPlaySongStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RecentlyPlaySongStatus.error));
    }
  }
}