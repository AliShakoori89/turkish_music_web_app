import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/category_model.dart';
import 'package:turkish_music_app/presentation/bloc/category_songs_for_mini_player_bloc/state.dart';
import '../../../domain/repositories/category_item_repository.dart';
import 'event.dart';

class CategorySongForMiniPlayerBloc extends Bloc<CategorySongForMiniPlayerEvent, CategorySongForMiniPlayerState> {

  CategoryItemRepository categoryItemRepository = CategoryItemRepository();

  CategorySongForMiniPlayerBloc(this.categoryItemRepository) : super(
      CategorySongForMiniPlayerState.initial()){
    on<GetCategorySongForMiniPlayerEvent>(_mapGetCategorySongForMiniPlayerEventToState);
    on<ResetCategorySongForMiniPlayerEvent>(_mapResetCategorySongForMiniPlayerEventToState);
  }

  void _mapResetCategorySongForMiniPlayerEventToState(
      ResetCategorySongForMiniPlayerEvent event, Emitter<CategorySongForMiniPlayerState> emit) {
    emit(CategorySongForMiniPlayerState.initial());  // Reset the state to the initial empty state
  }

  void _mapGetCategorySongForMiniPlayerEventToState(
      GetCategorySongForMiniPlayerEvent event, Emitter<CategorySongForMiniPlayerState> emit) async {
    try {
      emit(state.copyWith(status: CategorySongForMiniPlayerStatus.loading));

      CategoryDataModel categoryData = await categoryItemRepository.getCategorySongs(event.categoryID);

      emit(
        state.copyWith(
            status: CategorySongForMiniPlayerStatus.success,
            category: categoryData
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CategorySongForMiniPlayerStatus.error));
    }
  }
}