import '../../../data/model/user_model.dart';

abstract class AuthenticationEvent {
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLoggedInEvent extends AuthenticationEvent {
  final UserModel user;

  UserLoggedInEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationAuthenticatedEvent extends AuthenticationEvent {
  final UserModel user;

  AuthenticationAuthenticatedEvent({required this.user});

  @override
  List<Object> get props => [user];
}

