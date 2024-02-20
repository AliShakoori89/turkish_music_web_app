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
  final String verficationToken;

  SecondLoginEvent({
    required this.email, required this.verficationToken
  });

  @override
  List<Object> get props => [email, verficationToken];
}

//********************************************************************

class UserExistEvent extends UserEvent {}

class UserLoggedInEvent extends UserEvent {
  final UserModel user;

  UserLoggedInEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedOutEvent extends UserEvent {}