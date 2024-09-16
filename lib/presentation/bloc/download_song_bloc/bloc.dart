import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import 'package:turkish_music_app/domain/repositories/download_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/recently_play_song_repository.dart';
import 'package:turkish_music_app/presentation/bloc/download_song_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/recently_play_song_bloc/state.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import 'event.dart';

class DownloadSongBloc extends Bloc<DownloadSongEvent, DownloadSongState> {

  DownloadSongRepository downloadSongRepository = DownloadSongRepository();

  DownloadSongBloc(this.downloadSongRepository) : super(
      DownloadSongState.initial()){
    on<GetAllDownloadSongEvent>(_mapGetAllDownloadSongEventEventToState);
  }

  void _mapGetAllDownloadSongEventEventToState(
      GetAllDownloadSongEvent event, Emitter<DownloadSongState> emit) async {
    try {
      emit(state.copyWith(status: DownloadSongStatus.loading));

      // List<AlbumDataMusicModel> allRecentlySongs = await downloadSongRepository.getAllSongsRepo();

      emit(
        state.copyWith(
          status: DownloadSongStatus.success,
          // allDownloadSong: allRecentlySongs
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: DownloadSongStatus.error));
    }
  }
}