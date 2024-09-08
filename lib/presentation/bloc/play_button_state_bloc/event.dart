abstract class PlayButtonEvent {
  List<Object> get props => [];
}

class SetPlayButtonStateEvent extends PlayButtonEvent{
  final bool playButtonState;

  SetPlayButtonStateEvent({
    required this.playButtonState});

  @override
  List<Object> get props => [playButtonState];
}

class GetPlayButtonStateEvent extends PlayButtonEvent{}