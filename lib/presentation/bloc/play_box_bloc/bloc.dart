import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/state.dart';
import '../../../data/model/new-song_model.dart';
import '../../../domain/repositories/play_box_repository.dart';
import 'event.dart';

class PlayBoxBloc extends Bloc<PlayBoxEvent, PlayBoxState> {

  PlayBoxRepository playBoxRepository = PlayBoxRepository();

  PlayBoxBloc(this.playBoxRepository) : super(
      PlayBoxState.initial()){
    on<PlayBoxListEvent>(_mapPlayBoxListEventToState);
  }

  void _mapPlayBoxListEventToState(
      PlayBoxListEvent event, Emitter<PlayBoxState> emit) async {
    try {
      emit(state.copyWith(status: PlayBoxStatus.loading));

      List<NewSongDataModel> playBoxSong = await playBoxRepository.getPlayBox(event.songName);

      emit(
        state.copyWith(
            status: PlayBoxStatus.success,
          playBoxSong: playBoxSong
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: PlayBoxStatus.error));
    }
  }
}