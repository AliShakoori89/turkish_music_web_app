import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/state.dart';
import '../../../domain/repositories/mini_playing_container_repository.dart';
import 'event.dart';

class MiniPlayingContainerBloc extends Bloc<MiniPlayingContainerEvent, MiniPlayingContainerState> {

  MiniPlayingContainerRepository miniPlayingContainerRepository = MiniPlayingContainerRepository();

  MiniPlayingContainerBloc(this.miniPlayingContainerRepository) : super(
      MiniPlayingContainerState.initial()){
    on<FirstPlayingSongEvent>(_mapFirstLoginEventToState);
    on<CheckPlayingSongEvent>(_mapCheckLoginEventToState);
    on<WriteSongIDForMiniPlayingSongContainerEvent>(_mapWriteRequirementForMiniPlayingSongContainerEventToState);
    on<ReadSongIDForMiniPlayingSongContainerEvent>(_mapReadRequirementForMiniPlayingSongContainerEventToState);
  }

  void _mapFirstLoginEventToState(
      FirstPlayingSongEvent event, Emitter<MiniPlayingContainerState> emit) async {
    try {
      // emit(state.copyWith(status: MiniPlayingContainerStatus.loading));
      await miniPlayingContainerRepository.firstShowMiniPlayingContainer();
      bool visibility = await miniPlayingContainerRepository.isItTheFirstTimeTtIsShown();
      emit(
        state.copyWith(
          status: MiniPlayingContainerStatus.success,
          visibility: visibility,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MiniPlayingContainerStatus.error));
    }
  }

  void _mapCheckLoginEventToState(
      CheckPlayingSongEvent event, Emitter<MiniPlayingContainerState> emit) async {
    try {
      // emit(state.copyWith(status: MiniPlayingContainerStatus.loading));
      bool visibility = await miniPlayingContainerRepository.isItTheFirstTimeTtIsShown();
      emit(
        state.copyWith(
          status: MiniPlayingContainerStatus.success,
          visibility: visibility,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MiniPlayingContainerStatus.error));
    }
  }

  void _mapWriteRequirementForMiniPlayingSongContainerEventToState(
      WriteSongIDForMiniPlayingSongContainerEvent event, Emitter<MiniPlayingContainerState> emit) async {
    try {
      // emit(state.copyWith(status: MiniPlayingContainerStatus.loading));
      await miniPlayingContainerRepository.writeMiniPlayingRequirement(event.songID, event.albumID);
      List requirement = await miniPlayingContainerRepository.readMiniPlayingRequirement();

      emit(
        state.copyWith(
          status: MiniPlayingContainerStatus.success,
          albumID: requirement[1],
          songID: requirement[0]
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MiniPlayingContainerStatus.error));
    }
  }

  void _mapReadRequirementForMiniPlayingSongContainerEventToState(
      ReadSongIDForMiniPlayingSongContainerEvent event, Emitter<MiniPlayingContainerState> emit) async {
    try {
      // emit(state.copyWith(status: MiniPlayingContainerStatus.loading));
      List requirement = await miniPlayingContainerRepository.readMiniPlayingRequirement();
      emit(
        state.copyWith(
          status: MiniPlayingContainerStatus.success,
          songID: requirement[0],
          albumID: requirement[1],
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MiniPlayingContainerStatus.error));
    }
  }


}