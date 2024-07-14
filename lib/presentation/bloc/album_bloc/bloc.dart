import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import '../../../data/model/new_album_model.dart';
import '../../../data/model/singer_model.dart';
import '../../../domain/repositories/album_repository.dart';
import 'event.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {

  AlbumRepository albumRepository = AlbumRepository();

  AlbumBloc(this.albumRepository) : super(
      AlbumState.initial()){
    on<GetNewAlbumEvent>(_mapGetNewAlbumEventToState);
    on<GetSingerAllAlbumEvent>(_mapGetSingerAllAlbumEventToState);
  }

  void _mapGetNewAlbumEventToState(
      GetNewAlbumEvent event, Emitter<AlbumState> emit) async {
    try {
      emit(state.copyWith(status: AlbumStatus.loading));
      NewAlbumModel newAlbum = await albumRepository.getNewAlbum();
      emit(
        state.copyWith(
            status: AlbumStatus.success,
            newAlbum: newAlbum
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AlbumStatus.error));
    }
  }

  void _mapGetSingerAllAlbumEventToState(
      GetSingerAllAlbumEvent event, Emitter<AlbumState> emit) async {
    try {
      emit(state.copyWith(status: AlbumStatus.loading));
      List<AlbumDataModel> singerAllAlbum = await albumRepository.getSingerAllAlbum(event.id);
      emit(
        state.copyWith(
            status: AlbumStatus.success,
            singerAllAlbum: singerAllAlbum
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AlbumStatus.error));
    }
  }
}