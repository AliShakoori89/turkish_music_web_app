import 'package:equatable/equatable.dart';

enum LoginUserExistStatus { initial, success, error, loading }

extension USerExistStatusX on LoginUserExistStatus {
  bool get isInitial => this == LoginUserExistStatus.initial;
  bool get isSuccess => this == LoginUserExistStatus.success;
  bool get isError => this == LoginUserExistStatus.error;
  bool get isLoading => this == LoginUserExistStatus.loading;
}

class LoginUserExistState extends Equatable{

  const LoginUserExistState({
    required this.status,
    required this.userExistMessage,
    required this.userExistStatus
  });

  static LoginUserExistState initial() => LoginUserExistState(
    status: LoginUserExistStatus.initial,
    userExistMessage: '',
    userExistStatus: false
  );

  final LoginUserExistStatus status;
  final String userExistMessage;
  final bool userExistStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [status, userExistMessage, userExistStatus];

  LoginUserExistState copyWith({
    LoginUserExistStatus? status,
    String? userExist,
    bool? userStatus

  }) {
    return LoginUserExistState(
      status: status ?? this.status,
      userExistMessage: userExist ?? this.userExistMessage,
      userExistStatus: userStatus ?? this.userExistStatus
    );
  }
}