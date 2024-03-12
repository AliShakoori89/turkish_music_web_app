import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import '../../../data/model/new_album_model.dart';
import '../../../domain/repositories/album_repository.dart';
import 'event.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {

  AlbumRepository albumRepository = AlbumRepository();

  AlbumBloc(this.albumRepository) : super(
      AlbumState.initial()){
    on<GetNewAlbumEvent>(_mapGetNewAlbumEventToState);
  }

  void _mapGetNewAlbumEventToState(
      GetNewAlbumEvent event, Emitter<AlbumState> emit) async {
    try {
      emit(state.copyWith(status: AlbumStatus.loading));
      List<NewAlbumDataModel> newAlbum = await albumRepository.getNewAlbum();
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
}