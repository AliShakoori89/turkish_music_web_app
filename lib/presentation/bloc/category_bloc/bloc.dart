import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/category_model.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import '../../../domain/repositories/category_repository.dart';
import 'event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryRepository categoryRepository = CategoryRepository();

  CategoryBloc(this.categoryRepository) : super(
      CategoryState.initial()){
    on<GetCategoryEvent>(_mapGetCategoryEventToState);
    on<GetCategorySongsByIDEvent>(_mapGetCategorySongsByIDEventToState);
    on<ResetCategorySongsByIDEvent>(_mapResetCategorySongsByIDEventToState);
  }

  void _mapResetCategorySongsByIDEventToState(
      ResetCategorySongsByIDEvent event, Emitter<CategoryState> emit) {
    emit(CategoryState.initial());  // Reset the state to the initial empty state
  }

  void _mapGetCategoryEventToState(
      GetCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(state.copyWith(status: CategoryStatus.loading));

      List<CategoryDataModel> categoryData = await categoryRepository.getAllCategory();

      emit(
        state.copyWith(
          status: CategoryStatus.success,
          allCategory: categoryData
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapGetCategorySongsByIDEventToState(
      GetCategorySongsByIDEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(state.copyWith(status: CategoryStatus.loading));

      print("111111111111111111111111111111111111111");

      CategoryDataModel categoryData = await categoryRepository.getCategorySongs(event.categoryID);

      emit(
        state.copyWith(
            status: CategoryStatus.success,
            category: categoryData
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }
}