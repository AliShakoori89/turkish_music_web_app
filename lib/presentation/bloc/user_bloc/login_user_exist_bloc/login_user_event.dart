
abstract class LoginUserExistEvent {
  List<Object> get props => [];
}

class CheckUserExistEvent extends LoginUserExistEvent{
  final String email;

  CheckUserExistEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
