import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/play_music_repository.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/state.dart';

class IsPlayingMusicBloc extends Bloc<IsPlayingMusicEvent, IsPlayingMusicState> {

  IsPlayingMusicRepository isPlayingMusicRepository = IsPlayingMusicRepository();

  IsPlayingMusicBloc(this.isPlayingMusicRepository) : super(
      IsPlayingMusicState.initial()){
    on<SetIsPlayingMusicEvent>(_mapSetIsPlayingMusicEventToState);
    on<GetIsPlayingMusicEvent>(_mapGetIsPlayingMusicEventToState);
  }

  void _mapSetIsPlayingMusicEventToState(
      SetIsPlayingMusicEvent event, Emitter<IsPlayingMusicState> emit) async {
    try {
      emit(state.copyWith(status: IsPlayingMusicStatus.loading));
      isPlayingMusicRepository.setMusicIsPlaying(
          event.musicFilePath,
          event.singerName,
          event.imagePath,
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


      emit(
        state.copyWith(
          status: IsPlayingMusicStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: IsPlayingMusicStatus.error));
    }
  }
}