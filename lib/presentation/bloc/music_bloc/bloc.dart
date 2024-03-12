import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/state.dart';
import '../../../domain/repositories/music_repository.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {

  MusicRepository musicRepository = MusicRepository();

  MusicBloc(this.musicRepository) : super(
      MusicState.initial()){
    on<GetMusicEvent>(_mapGetMusicEventToState);
  }

  void _mapGetMusicEventToState(
      GetMusicEvent event, Emitter<MusicState> emit) async {
    try {
      emit(state.copyWith(status: MusicStatus.loading));
      bool onlineMode = await musicRepository.getMusic(event.musicId);

      emit(
        state.copyWith(
          status: MusicStatus.success,

        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MusicStatus.error));
    }
  }
}