import 'package:equatable/equatable.dart';

enum UserStatus { initial, success, error, loading }

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;
  bool get isSuccess => this == UserStatus.success;
  bool get isError => this == UserStatus.error;
  bool get isLoading => this == UserStatus.loading;
}

class RegisterUserState extends Equatable{

  const RegisterUserState({
    required this.status,
    required this.requestPublic,
    required this.firstRegisterStatus,
    required this.secondRegisterStatus,
  });

  static RegisterUserState initial() => RegisterUserState(
    status: UserStatus.initial,
    requestPublic: false,
    firstRegisterStatus: false,
    secondRegisterStatus: false,
  );

  final UserStatus status;
  final bool firstRegisterStatus;
  final bool secondRegisterStatus;
  final bool requestPublic;

  @override
  // TODO: implement props
  List<Object?> get props => [status, requestPublic, firstRegisterStatus,
    secondRegisterStatus];

  RegisterUserState copyWith({
    UserStatus? status,
    bool? requestPublic,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus,
  }) {
    return RegisterUserState(
      status: status ?? this.status,
      requestPublic: requestPublic ?? this.requestPublic,
      firstRegisterStatus: firstRegisterStatus ?? this.firstRegisterStatus,
      secondRegisterStatus: secondRegisterStatus ?? this.secondRegisterStatus,
    );
  }
}