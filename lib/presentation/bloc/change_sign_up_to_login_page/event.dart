abstract class ChangeSignUoToLoginEvent {
  List<Object> get props => [];
}

class IsSignUpEvent extends ChangeSignUoToLoginEvent{
  final bool isSignUp;

  IsSignUpEvent({
    required this.isSignUp});

  @override
  List<Object> get props => [isSignUp];
}