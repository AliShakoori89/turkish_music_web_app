import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/domain/repositories/singer_repository.dart';
import 'package:turkish_music_app/presentation/bloc/singer_bloc/state.dart';
import 'event.dart';

class SingerBloc extends Bloc<SingerEvent, SingerState> {

  SingerRepository singerRepository = SingerRepository();

  SingerBloc(this.singerRepository) : super(
      SingerState.initial()){
    on<GetFamousSingerEvent>(_mapGetFamousSingerEventToState);
    on<GetAllSingerEvent>(_mapGetAllSingerEventToState);
    on<GetAllSingerNameEvent>(_mapGetAllSingerNameEventToState);
  }

  void _mapGetFamousSingerEventToState(
      GetFamousSingerEvent event, Emitter<SingerState> emit) async {
    try {
      emit(state.copyWith(status: SingerStatus.loading));

      List<SingerDataModel> famousSinger = await singerRepository.getFamousSinger();

      emit(
        state.copyWith(
          status: SingerStatus.success,
          famousSinger: famousSinger
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SingerStatus.error));
    }
  }

  void _mapGetAllSingerEventToState(
      GetAllSingerEvent event, Emitter<SingerState> emit) async {
    try {
      emit(state.copyWith(status: SingerStatus.loading));

      List<SingerDataModel> allSinger = await singerRepository.getAllSinger();

      emit(
        state.copyWith(
            status: SingerStatus.success,
            allSinger: allSinger
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SingerStatus.error));
    }
  }

  void _mapGetAllSingerNameEventToState(
      GetAllSingerNameEvent event, Emitter<SingerState> emit) async {
    try {
      emit(state.copyWith(status: SingerStatus.loading));

      List<String> allSingerName = await singerRepository.getAllSingerName();

      emit(
        state.copyWith(
          status: SingerStatus.success,
          allSingerName: allSingerName,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SingerStatus.error));
    }
  }
}