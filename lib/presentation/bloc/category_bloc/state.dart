import 'package:equatable/equatable.dart';

import '../../../data/model/category_model.dart';

enum CategoryStatus { initial, success, error, loading }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isLoading => this == CategoryStatus.loading;
}

class CategoryState extends Equatable{

  const CategoryState({
    required this.status,
    required this.allCategory,
    required this.category
  });

  static CategoryState initial() => CategoryState(
    status: CategoryStatus.initial,
    allCategory: <CategoryDataModel>[],
    category: CategoryDataModel(),
  );

  final CategoryStatus status;
  final List<CategoryDataModel> allCategory;
  final CategoryDataModel category;

  @override
  // TODO: implement props
  List<Object?> get props => [status, allCategory, category];

  CategoryState copyWith({
    CategoryStatus? status,
    List<CategoryDataModel>? allCategory,
    CategoryDataModel? category
  }) {
    return CategoryState(
      status: status ?? this.status,
      allCategory: allCategory ?? this.allCategory,
      category: category ?? this.category
    );
  }
}