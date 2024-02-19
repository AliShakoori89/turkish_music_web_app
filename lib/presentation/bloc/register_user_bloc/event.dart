abstract class RegisterEvent {
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent{
  final String email;

  RegisterUserEvent({
    required this.email});

  @override
  List<Object> get props => [email];
}

class FirstLoginEvent extends RegisterEvent{
  final String email;

  FirstLoginEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class SecondLoginEvent extends RegisterEvent{
  final String email;
  final String verficationToken;

  SecondLoginEvent({
    required this.email, required this.verficationToken
  });

  @override
  List<Object> get props => [email, verficationToken];
}