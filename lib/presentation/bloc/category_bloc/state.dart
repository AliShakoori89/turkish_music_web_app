import 'package:equatable/equatable.dart';

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
  });

  static CategoryState initial() => const CategoryState(
      status: CategoryStatus.initial,
  );

  final CategoryStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  CategoryState copyWith({
    CategoryStatus? status,
  }) {
    return CategoryState(
        status: status ?? this.status,
    );
  }
}