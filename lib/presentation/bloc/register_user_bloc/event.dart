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

class RegisterUserViaOTPCodeEvent extends RegisterEvent{
  final String email;

  RegisterUserViaOTPCodeEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}