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
  }

  void _mapGetCategoryEventToState(
      GetCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(state.copyWith(status: CategoryStatus.loading));
print("22222222222222222222");
      List<CategoryDataModel> categoryData = await categoryRepository.getAllCategory();

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