import '../../../data/model/user_model.dart';

abstract class UserEvent {
  List<Object> get props => [];
}

class RegisterUserEvent extends UserEvent{
  final String email;

  RegisterUserEvent({
    required this.email});

  @override
  List<Object> get props => [email];
}

class FirstLoginEvent extends UserEvent{
  final String email;

  FirstLoginEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class SecondLoginEvent extends UserEvent{
  final String email;
  final String verificationToken;

  SecondLoginEvent({
    required this.email, required this.verificationToken
  });

  @override
  List<Object> get props => [email, verificationToken];
}

class GetCurrentUser extends UserEvent{}
