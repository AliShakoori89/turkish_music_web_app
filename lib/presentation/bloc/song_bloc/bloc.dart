import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/state.dart';
import '../../../data/model/song_model.dart';
import '../../../domain/repositories/song_repository.dart';
import 'event.dart';

class SongBloc extends Bloc<SongEvent, SongState> {

  SongRepository songRepository = SongRepository();

  SongBloc(this.songRepository) : super(
      SongState.initial()){
    on<GetSongEvent>(_mapGetMusicEventToState);
  }

  void _mapGetMusicEventToState(
      GetSongEvent event, Emitter<SongState> emit) async {
    try {
      emit(state.copyWith(status: SongStatus.loading));
      SongModel songDetail = await songRepository.getMusic(event.songId);

      emit(
        state.copyWith(
          status: SongStatus.success,
          songDetail: songDetail
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SongStatus.error));
    }
  }
}