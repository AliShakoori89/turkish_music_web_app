
abstract class RegUserExistEvent {
  List<Object> get props => [];
}

class CheckUserExistEvent extends RegUserExistEvent{
  final String email;

  CheckUserExistEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
