import '../../../data/model/user_model.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class AppLoadedEvent extends AuthenticationEvent {}

class UserLoggedInEvent extends AuthenticationEvent {
  final UserModel user;

  UserLoggedInEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class UserLoggedOutEvent extends AuthenticationEvent {}

