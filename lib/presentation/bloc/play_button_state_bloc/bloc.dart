import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/play_button_state_repository.dart';
import 'package:turkish_music_app/presentation/bloc/play_button_state_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/play_button_state_bloc/state.dart';

class PlayButtonStateBloc extends Bloc<PlayButtonEvent, PlayButtonState> {

  PlayButtonStateRepository playButtonStateRepository = PlayButtonStateRepository();

  PlayButtonStateBloc(this.playButtonStateRepository) : super(
      PlayButtonState.initial()) {
    on<SetPlayButtonStateEvent>(_mapSetPlayButtonStateEventEventToState);
    on<GetPlayButtonStateEvent>(_mapGetPlayButtonStateEventEventToState);
  }

  void _mapSetPlayButtonStateEventEventToState(SetPlayButtonStateEvent event,
      Emitter<PlayButtonState> emit) async {
    try {
      emit(state.copyWith(status: PlayButtonStatus.loading));

      await playButtonStateRepository.setPlayButtonState(event.playButtonState);
      var playButtonState = await playButtonStateRepository.getPlayButtonState();

      emit(
        state.copyWith(
            status: PlayButtonStatus.success,
          playButtonState: playButtonState
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayButtonStatus.error));
    }
  }

  void _mapGetPlayButtonStateEventEventToState(GetPlayButtonStateEvent event,
      Emitter<PlayButtonState> emit) async {
    try {
      emit(state.copyWith(status: PlayButtonStatus.loading));

      var playButtonState = await playButtonStateRepository.getPlayButtonState();

      emit(
        state.copyWith(
            status: PlayButtonStatus.success,
            playButtonState: playButtonState
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayButtonStatus.error));
    }
  }
}