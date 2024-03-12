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
}