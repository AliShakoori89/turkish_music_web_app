import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/state.dart';
import '../../../domain/repositories/play_list_repository.dart';
import 'event.dart';

class PlaylistBloc extends Bloc<PlayListEvent, PlaylistState> {

  PlayListRepository playListRepository = PlayListRepository();

  PlaylistBloc(this.playListRepository) : super(
      PlaylistState.initial()){
    on<AddMusicToPlaylistEvent>(_mapAddMusicToPlaylistEventToState);
    on<RemoveMusicFromPlaylistEvent>(_mapRemoveMusicFromPlaylistEventToState);
    on<GetAllMusicInPlaylistEvent>(_mapGetAllMusicInPlaylistEventToState);
  }

  void _mapAddMusicToPlaylistEventToState(
      AddMusicToPlaylistEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      await playListRepository.addToPlayList(event.userID, event.musicID);

      emit(
        state.copyWith(
            status: PlayListStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }

  void _mapRemoveMusicFromPlaylistEventToState(
      RemoveMusicFromPlaylistEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      await playListRepository.removeFromPlayList(event.userID, event.musicID);


      emit(
        state.copyWith(
          status: PlayListStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }

  void _mapGetAllMusicInPlaylistEventToState(
      GetAllMusicInPlaylistEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      List<SongDataModel> playlistSongs = await playListRepository.getMusicToPlayList();

      emit(
        state.copyWith(
          status: PlayListStatus.success,
          playlistSongs: playlistSongs
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }
}