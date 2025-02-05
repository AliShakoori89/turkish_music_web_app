abstract class CategorySongForMiniPlayerEvent {
  List<Object> get props => [];
}

class GetCategorySongForMiniPlayerEvent extends CategorySongForMiniPlayerEvent{
  final int categoryID;

  GetCategorySongForMiniPlayerEvent({required this.categoryID});

  @override
  List<Object> get props => [categoryID];
}

class ResetCategorySongForMiniPlayerEvent extends CategorySongForMiniPlayerEvent {}