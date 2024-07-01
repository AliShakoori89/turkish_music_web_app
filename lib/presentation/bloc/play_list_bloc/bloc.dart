import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/state.dart';
import '../../../data/model/playListSongModel.dart';
import '../../../domain/repositories/play_list_repository.dart';
import 'event.dart';

class PlaylistBloc extends Bloc<PlayListEvent, PlaylistState> {

  PlayListRepository playListRepository = PlayListRepository();

  PlaylistBloc(this.playListRepository) : super(
      PlaylistState.initial()){
    on<AddMusicToPlaylistEvent>(_mapAddMusicToPlaylistEventToState);
    on<RemoveMusicFromPlaylistEvent>(_mapRemoveMusicFromPlaylistEventToState);
    on<GetAllMusicInPlaylistEvent>(_mapGetAllMusicInPlaylistEventToState);
    on<SaveSongIDEvent>(_mapSaveSongIDEventToState);
    on<RemoveSongIDEvent>(_mapRemoveSongIDEventToState);
    on<SearchSongIDEvent>(_mapSearchSongIDEventToState);
  }

  void _mapAddMusicToPlaylistEventToState(
      AddMusicToPlaylistEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      await playListRepository.addToPlayList(event.songID);
      List<PlaylistMusicModel> playlistSongs = await playListRepository.getMusicFromPlayList();


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

  void _mapRemoveMusicFromPlaylistEventToState(
      RemoveMusicFromPlaylistEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      await playListRepository.removeFromPlayList(event.musicID);
      List<PlaylistMusicModel> playlistSongs = await playListRepository.getMusicFromPlayList();

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

  void _mapGetAllMusicInPlaylistEventToState(
      GetAllMusicInPlaylistEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      List<PlaylistMusicModel> playlistSongs = await playListRepository.getMusicFromPlayList();

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

  void _mapSaveSongIDEventToState(
      SaveSongIDEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));
      playListRepository.addMusicIDToList(event.songID);
      bool isFavorite = playListRepository.isMusicInPlaylist(event.songID);

      emit(
        state.copyWith(
            status: PlayListStatus.success,
          isFavorite: isFavorite
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }

  void _mapRemoveSongIDEventToState(
      RemoveSongIDEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));
      playListRepository.removeMusicIDFromList(event.songID);
      bool isFavorite =  playListRepository.isMusicInPlaylist(event.songID);

      emit(
        state.copyWith(
          status: PlayListStatus.success,
          isFavorite: isFavorite
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }

  void _mapSearchSongIDEventToState(
      SearchSongIDEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));
      bool isFavorite = playListRepository.isMusicInPlaylist(event.songID);
      emit(
        state.copyWith(
          status: PlayListStatus.success,
          isFavorite: isFavorite
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }
}