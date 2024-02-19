import 'package:equatable/equatable.dart';
import '../../../data/model/user_model.dart';

enum AuthenticationStatus { initial, success, error, loading }

extension AuthenticationStatusX on AuthenticationStatus {
  bool get isInitial => this == AuthenticationStatus.initial;
  bool get isSuccess => this == AuthenticationStatus.success;
  bool get isError => this == AuthenticationStatus.error;
  bool get isLoading => this == AuthenticationStatus.loading;
}

class AuthenticationState extends Equatable{

  const AuthenticationState({required this.status, required this.user});

  static AuthenticationState initial() => const AuthenticationState(
    status: AuthenticationStatus.initial,
    user: null
  );

  final AuthenticationStatus status;
  final UserModel? user;


  @override
  // TODO: implement props
  List<Object?> get props => [ status, user];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserModel? user
  }){
    return AuthenticationState(
        status: status ?? this.status,
        user: user ?? this.user
    );
  }
}