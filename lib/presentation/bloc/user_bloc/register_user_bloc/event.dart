
abstract class RegisterUserEvent {
  List<Object> get props => [];
}

class RegistrationUserEvent extends RegisterUserEvent{
  final String email;

  RegistrationUserEvent({
    required this.email});

  @override
  List<Object> get props => [email];
}
