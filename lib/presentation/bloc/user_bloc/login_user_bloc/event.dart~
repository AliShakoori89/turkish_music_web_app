
abstract class LoginUserEvent {
  List<Object> get props => [];
}

class FirstLoginEvent extends LoginUserEvent{
  final String email;

  FirstLoginEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class UserExistEvent extends LoginUserEvent{
  final String email;

  UserExistEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class SecondLoginEvent extends LoginUserEvent{
  final String email;
  final String verificationToken;

  SecondLoginEvent({
    required this.email, required this.verificationToken
  });

  @override
  List<Object> get props => [email, verificationToken];
}
