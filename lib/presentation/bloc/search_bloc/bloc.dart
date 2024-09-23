import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/domain/repositories/singer_repository.dart';
import 'package:turkish_music_app/presentation/bloc/search_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/singer_bloc/state.dart';
import '../../../domain/repositories/search_repository.dart';
import 'event.dart';

class SearchWordBloc extends Bloc<SearchWordEvent, SearchWordState> {

  SearchRepository searchRepository = SearchRepository();

  SearchWordBloc(this.searchRepository) : super(
      SearchWordState.initial()){
    on<SearchEspecialWordEvent>(_mapSearchEspecialWordEventToState);
  }

  void _mapSearchEspecialWordEventToState(
      SearchEspecialWordEvent event, Emitter<SearchWordState> emit) async {
    try {
      emit(state.copyWith(status: SearchWordStatus.loading));

      List<String> especialWord = await searchRepository.getSearchSong(event.especialWord);

      emit(
        state.copyWith(
            status: SearchWordStatus.success,
            especialWord: especialWord
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SearchWordStatus.error));
    }
  }
}