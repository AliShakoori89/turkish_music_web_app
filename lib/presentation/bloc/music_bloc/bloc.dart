import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/state.dart';
import '../../../domain/repositories/music_repository.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {

  MusicRepository musicRepository = MusicRepository();

  MusicBloc(this.musicRepository) : super(
      MusicState.initial()){
    on<GetNewMusicEvent>(_mapGetNewMusicEventToState);
    on<GetFamousArtistEvent>(_mapGetFamousArtistEventToState);
    on<GetNewAlbumEvent>(_mapGetNewAlbumEventToState);
  }

  void _mapGetNewMusicEventToState(
      GetNewMusicEvent event, Emitter<MusicState> emit) async {
    try {
      emit(state.copyWith(status: MusicStatus.loading));
      List<NewMusicDataModel> newSong = await musicRepository.getNewMusic();

      emit(
        state.copyWith(
          status: MusicStatus.success,
          newMusic: newSong
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MusicStatus.error));
    }
  }

  void _mapGetFamousArtistEventToState(
      GetFamousArtistEvent event, Emitter<MusicState> emit) async {
    try {
      emit(state.copyWith(status: MusicStatus.loading));

      List<SingerDataModel> famousArtist = await musicRepository.getFamousArtist();

      emit(
        state.copyWith(
          status: MusicStatus.success,
          famousArtist: famousArtist
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MusicStatus.error));
    }
  }

  void _mapGetNewAlbumEventToState(
      GetNewAlbumEvent event, Emitter<MusicState> emit) async {
    try {
      emit(state.copyWith(status: MusicStatus.loading));
      print("4444444444444444444444");
      List<NewAlbumModel> newAlbum = await musicRepository.getNewAlbum();
      print("55555555555555555555555555");
      emit(
        state.copyWith(
            status: MusicStatus.success,
            newAlbum: newAlbum
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MusicStatus.error));
    }
  }
}