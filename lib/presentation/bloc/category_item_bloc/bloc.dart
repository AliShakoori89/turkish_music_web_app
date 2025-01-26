import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/category_model.dart';
import 'package:turkish_music_app/presentation/bloc/category_item_bloc/state.dart';
import '../../../domain/repositories/category_item_repository.dart';
import 'event.dart';

class CategoryItemBloc extends Bloc<CategoryItemEvent, CategoryItemState> {

  CategoryItemRepository categoryItemRepository = CategoryItemRepository();

  CategoryItemBloc(this.categoryItemRepository) : super(
      CategoryItemState.initial()){
    on<GetCategorySongsByIDEvent>(_mapGetCategorySongsByIDEventToState);
    on<ResetCategorySongsEvent>(_mapResetCategorySongsByIDEventToState);
  }

  void _mapResetCategorySongsByIDEventToState(
      ResetCategorySongsEvent event, Emitter<CategoryItemState> emit) {
    emit(CategoryItemState.initial());  // Reset the state to the initial empty state
  }

  void _mapGetCategorySongsByIDEventToState(
      GetCategorySongsByIDEvent event, Emitter<CategoryItemState> emit) async {
    try {
      emit(state.copyWith(status: CategoryItemStatus.loading));

      CategoryDataModel categoryData = await categoryItemRepository.getCategorySongs(event.categoryID);

      emit(
        state.copyWith(
            status: CategoryItemStatus.success,
            category: categoryData
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CategoryItemStatus.error));
    }
  }
}