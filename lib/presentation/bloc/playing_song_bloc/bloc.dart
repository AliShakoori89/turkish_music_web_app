import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/play_song_repository.dart';
import 'package:turkish_music_app/presentation/bloc/playing_song_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/playing_song_bloc/state.dart';

class PlayingSongBloc extends Bloc<PlayingSongEvent, PlayingSongState> {

  IsPlayingMusicRepository isPlayingMusicRepository = IsPlayingMusicRepository();

  PlayingSongBloc(this.isPlayingMusicRepository) : super(
      PlayingSongState.initial()){
    on<SetPlayingSongEvent>(_mapSetPlayingSongEventToState);
    on<SetPreviousSongFileEvent>(_mapSetPreviousSongFileEventToState);
    on<GetPlayingSongEvent>(_mapGetPlayingSongEventToState);
    on<GetPreviousSongFileEvent>(_mapGetPreviousSongFileEventToState);
  }

  void _mapSetPlayingSongEventToState(
      SetPlayingSongEvent event, Emitter<PlayingSongState> emit) async {
    try {
      emit(state.copyWith(status: PlayingSongStatus.loading));

      isPlayingMusicRepository.setMusicIsPlaying(
          event.songFilePath,
          event.singerName,
          event.imagePath,
          event.isPlaying,
          );

      emit(
        state.copyWith(
            status: PlayingSongStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayingSongStatus.error));
    }
  }

  void _mapSetPreviousSongFileEventToState(
      SetPreviousSongFileEvent event, Emitter<PlayingSongState> emit) async {
    try {
      emit(state.copyWith(status: PlayingSongStatus.loading));

      isPlayingMusicRepository.setPreviousSong(
        event.previousSongFilePath
      );

      emit(
        state.copyWith(
          status: PlayingSongStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayingSongStatus.error));
    }
  }

  void _mapGetPlayingSongEventToState(
      GetPlayingSongEvent event, Emitter<PlayingSongState> emit) async {
    try {
      emit(state.copyWith(status: PlayingSongStatus.loading));

      var musicFile = await isPlayingMusicRepository.getMusicFileIsPlaying();
      var musicSingerImage = await isPlayingMusicRepository.getMusicSingerImageIsPlaying();
      var musicSingerName = await isPlayingMusicRepository.getMusicSingerNameIsPlaying();
      var isPlaying = await isPlayingMusicRepository.getIsPlaying();

      emit(
        state.copyWith(
          status: PlayingSongStatus.success,
          songFile: musicFile,
          singerImage: musicSingerImage,
          singerName: musicSingerName,
          isPlaying: isPlaying
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayingSongStatus.error));
    }
  }

  void _mapGetPreviousSongFileEventToState(
      GetPreviousSongFileEvent event, Emitter<PlayingSongState> emit) async {
    try {
      emit(state.copyWith(status: PlayingSongStatus.loading));

      var previousSongFile = await isPlayingMusicRepository.getPreviousSong();

      emit(
        state.copyWith(
            status: PlayingSongStatus.success,
            previousSongFile: previousSongFile,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayingSongStatus.error));
    }
  }
}