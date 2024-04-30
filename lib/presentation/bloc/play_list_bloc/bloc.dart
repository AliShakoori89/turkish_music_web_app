import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/state.dart';
import '../../../domain/repositories/play_list_repository.dart';
import 'event.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {

  PlayListRepository playBoxRepository = PlayListRepository();

  PlayListBloc(this.playBoxRepository) : super(
      PlayListState.initial()){
    on<AddMusicToPlaylistEvent>(_mapAddMusicToPlaylistEventToState);
    on<RemoveMusicFromPlaylistEvent>(_mapRemoveMusicFromPlaylistEventToState);
    on<GetAllMusicInPlaylistEvent>(_mapGetAllMusicInPlaylistEventToState);
  }

  void _mapAddMusicToPlaylistEventToState(
      PlayListEvent event, Emitter<PlayListState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

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
      PlayListEvent event, Emitter<PlayListState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

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
      PlayListEvent event, Emitter<PlayListState> emit) async {
    try {
      emit(state.copyWith(status: PlayListStatus.loading));

      emit(
        state.copyWith(
          status: PlayListStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayListStatus.error));
    }
  }
}