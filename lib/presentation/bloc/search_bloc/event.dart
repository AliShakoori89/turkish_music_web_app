abstract class SearchWordEvent {
  List<Object> get props => [];
}

class SearchEspecialWordEvent extends SearchWordEvent{
  final String especialWord;

  SearchEspecialWordEvent({required this.especialWord});

  @override
  List<Object> get props => [especialWord];
}


