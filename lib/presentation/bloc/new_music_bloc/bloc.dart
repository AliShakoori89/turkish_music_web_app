import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/domain/repositories/new_music_repository.dart';
import 'package:turkish_music_app/presentation/bloc/new_music_bloc/state.dart';
import 'event.dart';

class NewMusicBloc extends Bloc<NewMusicEvent, NewMusicState> {

  NewMusicRepository newMusicRepository = NewMusicRepository();

  NewMusicBloc(this.newMusicRepository) : super(
      NewMusicState.initial()){
    on<GetNewMusicEvent>(_mapGetNewMusicEventToState);
  }

  void _mapGetNewMusicEventToState(
      GetNewMusicEvent event, Emitter<NewMusicState> emit) async {
    try {
      emit(state.copyWith(status: NewMusicStatus.loading));
      List<NewSongDataModel> newMusic = await newMusicRepository.getNewMusic();

      emit(
        state.copyWith(
          status: NewMusicStatus.success,
          newMusic: newMusic
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: NewMusicStatus.error));
    }
  }
}