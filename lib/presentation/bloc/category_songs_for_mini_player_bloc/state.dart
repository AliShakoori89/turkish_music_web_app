import 'package:equatable/equatable.dart';

import '../../../data/model/category_model.dart';

enum CategorySongForMiniPlayerStatus { initial, success, error, loading }

extension CategorySongForMiniPlayerStatusX on CategorySongForMiniPlayerStatus {
  bool get isInitial => this == CategorySongForMiniPlayerStatus.initial;
  bool get isSuccess => this == CategorySongForMiniPlayerStatus.success;
  bool get isError => this == CategorySongForMiniPlayerStatus.error;
  bool get isLoading => this == CategorySongForMiniPlayerStatus.loading;
}

class CategorySongForMiniPlayerState extends Equatable{

  const CategorySongForMiniPlayerState({
    required this.status,
    required this.allCategory,
    required this.category
  });

  static CategorySongForMiniPlayerState initial() => CategorySongForMiniPlayerState(
    status: CategorySongForMiniPlayerStatus.initial,
    allCategory: <CategoryDataModel>[],
    category: CategoryDataModel(),
  );

  final CategorySongForMiniPlayerStatus status;
  final List<CategoryDataModel> allCategory;
  final CategoryDataModel category;

  @override
  // TODO: implement props
  List<Object?> get props => [status, allCategory, category];

  CategorySongForMiniPlayerState copyWith({
    CategorySongForMiniPlayerStatus? status,
    List<CategoryDataModel>? allCategory,
    CategoryDataModel? category
  }) {
    return CategorySongForMiniPlayerState(
      status: status ?? this.status,
      allCategory: allCategory ?? this.allCategory,
      category: category ?? this.category
    );
  }
}