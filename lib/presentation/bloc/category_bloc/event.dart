abstract class CategoryEvent {
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoryEvent{}

class GetCategorySongsByIDEvent extends CategoryEvent{
  final int categoryID;

  GetCategorySongsByIDEvent({required this.categoryID});

  @override
  List<Object> get props => [categoryID];
}

class ResetCategorySongsByIDEvent extends CategoryEvent {}