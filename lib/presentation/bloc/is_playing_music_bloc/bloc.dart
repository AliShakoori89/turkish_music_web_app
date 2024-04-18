import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/play_music_repository.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/state.dart';

class IsPlayingMusicBloc extends Bloc<IsPlayingMusicEvent, IsPlayingMusicState> {

  IsPlayingMusicRepository isPlayingMusicRepository = IsPlayingMusicRepository();

  IsPlayingMusicBloc(this.isPlayingMusicRepository) : super(
      IsPlayingMusicState.initial()){
    on<SetIsPlayingMusicEvent>(_mapSetIsPlayingMusicEventToState);
    on<SetPreviousSongFileEvent>(_mapSetPreviousSongFileEventToState);
    on<GetIsPlayingMusicEvent>(_mapGetIsPlayingMusicEventToState);
    on<GetPreviousSongFileEvent>(_mapGetPreviousSongFileEventToState);
  }

  void _mapSetIsPlayingMusicEventToState(
      SetIsPlayingMusicEvent event, Emitter<IsPlayingMusicState> emit) async {
    try {
      emit(state.copyWith(status: IsPlayingMusicStatus.loading));

      isPlayingMusicRepository.setMusicIsPlaying(
          event.musicFilePath,
          event.singerName,
          event.imagePath,
          event.isPlaying,
          );

      emit(
        state.copyWith(
            status: IsPlayingMusicStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: IsPlayingMusicStatus.error));
    }
  }

  void _mapSetPreviousSongFileEventToState(
      SetPreviousSongFileEvent event, Emitter<IsPlayingMusicState> emit) async {
    try {
      emit(state.copyWith(status: IsPlayingMusicStatus.loading));

      isPlayingMusicRepository.setPreviousSong(
        event.previousSongFilePath
      );

      emit(
        state.copyWith(
          status: IsPlayingMusicStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: IsPlayingMusicStatus.error));
    }
  }

  void _mapGetIsPlayingMusicEventToState(
      GetIsPlayingMusicEvent event, Emitter<IsPlayingMusicState> emit) async {
    try {
      emit(state.copyWith(status: IsPlayingMusicStatus.loading));

      var musicFile = await isPlayingMusicRepository.getMusicFileIsPlaying();
      var musicSingerImage = await isPlayingMusicRepository.getMusicSingerImageIsPlaying();
      var musicSingerName = await isPlayingMusicRepository.getMusicSingerNameIsPlaying();
      var isPlaying = await isPlayingMusicRepository.getIsPlaying();

      emit(
        state.copyWith(
          status: IsPlayingMusicStatus.success,
          musicFile: musicFile,
          singerImage: musicSingerImage,
          singerName: musicSingerName,
          isPlaying: isPlaying
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: IsPlayingMusicStatus.error));
    }
  }

  void _mapGetPreviousSongFileEventToState(
      GetPreviousSongFileEvent event, Emitter<IsPlayingMusicState> emit) async {
    try {
      emit(state.copyWith(status: IsPlayingMusicStatus.loading));

      var previousSongFile = await isPlayingMusicRepository.getPreviousSong();

      emit(
        state.copyWith(
            status: IsPlayingMusicStatus.success,
            previousSongFile: previousSongFile,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: IsPlayingMusicStatus.error));
    }
  }
}