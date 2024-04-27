import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import '../../../data/model/new_album_model.dart';
import '../../../domain/repositories/album_repository.dart';
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
      emit(
        state.copyWith(
            status: CategoryStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }
}