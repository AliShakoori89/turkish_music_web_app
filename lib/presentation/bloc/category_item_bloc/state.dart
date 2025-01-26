import 'package:equatable/equatable.dart';

import '../../../data/model/category_model.dart';

enum CategoryItemStatus { initial, success, error, loading }

extension CategoryItemStatusX on CategoryItemStatus {
  bool get isInitial => this == CategoryItemStatus.initial;
  bool get isSuccess => this == CategoryItemStatus.success;
  bool get isError => this == CategoryItemStatus.error;
  bool get isLoading => this == CategoryItemStatus.loading;
}

class CategoryItemState extends Equatable{

  const CategoryItemState({
    required this.status,
    required this.allCategory,
    required this.category
  });

  static CategoryItemState initial() => CategoryItemState(
    status: CategoryItemStatus.initial,
    allCategory: <CategoryDataModel>[],
    category: CategoryDataModel(),
  );

  final CategoryItemStatus status;
  final List<CategoryDataModel> allCategory;
  final CategoryDataModel category;

  @override
  // TODO: implement props
  List<Object?> get props => [status, allCategory, category];

  CategoryItemState copyWith({
    CategoryItemStatus? status,
    List<CategoryDataModel>? allCategory,
    CategoryDataModel? category
  }) {
    return CategoryItemState(
      status: status ?? this.status,
      allCategory: allCategory ?? this.allCategory,
      category: category ?? this.category
    );
  }
}