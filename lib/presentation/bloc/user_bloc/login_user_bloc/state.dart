import 'package:equatable/equatable.dart';

enum UserStatus { initial, success, error, loading }

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;
  bool get isSuccess => this == UserStatus.success;
  bool get isError => this == UserStatus.error;
  bool get isLoading => this == UserStatus.loading;
}

class LoginUserState extends Equatable{

  const LoginUserState({
    required this.status,
    required this.userExist,
    required this.firstRegisterStatus,
    required this.secondRegisterStatus,
  });

  static LoginUserState initial() => LoginUserState(
    status: UserStatus.initial,
    userExist: '',
    firstRegisterStatus: false,
    secondRegisterStatus: false,
  );

  final UserStatus status;
  final String userExist;
  final bool firstRegisterStatus;
  final bool secondRegisterStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [status, userExist, firstRegisterStatus,
    secondRegisterStatus];

  LoginUserState copyWith({
    UserStatus? status,
    String? userExist,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus,
  }) {
    return LoginUserState(
      status: status ?? this.status,
      userExist: userExist ?? this.userExist,
      firstRegisterStatus: firstRegisterStatus ?? this.firstRegisterStatus,
      secondRegisterStatus: secondRegisterStatus ?? this.secondRegisterStatus,
    );
  }
}