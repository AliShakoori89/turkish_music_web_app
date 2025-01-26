abstract class CategoryItemEvent {
  List<Object> get props => [];
}

class GetCategorySongsByIDEvent extends CategoryItemEvent{
  final int categoryID;

  GetCategorySongsByIDEvent({required this.categoryID});

  @override
  List<Object> get props => [categoryID];
}

class ResetCategorySongsEvent extends CategoryItemEvent {}