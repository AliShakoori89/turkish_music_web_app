import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/domain/repositories/new_song_repository.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/state.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import 'event.dart';

class NewSongBloc extends Bloc<NewSongEvent, NewSongState> {

  NewSongRepository newSongRepository = NewSongRepository();

  NewSongBloc(this.newSongRepository) : super(
      NewSongState.initial()){
    on<GetNewSongEvent>(_mapGetNewMusicEventToState);
    on<GetAllNewSongEvent>(_mapGetAllNewMusicEventToState);
  }

  void _mapGetNewMusicEventToState(
      GetNewSongEvent event, Emitter<NewSongState> emit) async {
    try {
      emit(state.copyWith(status: NewSongStatus.loading));

      List<NewSongDataModel> newMusic = await newSongRepository.getNewMusic();

      emit(
        state.copyWith(
          status: NewSongStatus.success,
          newMusic: newMusic
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: NewSongStatus.error));
    }
  }

  void _mapGetAllNewMusicEventToState(
      GetAllNewSongEvent event, Emitter<NewSongState> emit) async {
    try {
      emit(state.copyWith(status: NewSongStatus.loading));

      List<NewSongDataModel> allNewMusic = await newSongRepository.getAllNewMusic();

      emit(
        state.copyWith(
            status: NewSongStatus.success,
            allNewSong: allNewMusic
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: NewSongStatus.error));
    }
  }
}