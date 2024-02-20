import 'package:equatable/equatable.dart';

enum UserStatus { initial, success, error, loading }

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;
  bool get isSuccess => this == UserStatus.success;
  bool get isError => this == UserStatus.error;
  bool get isLoading => this == UserStatus.loading;
}

class UserState extends Equatable{

  const UserState ({
    this.status = UserStatus.initial,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus
  }): firstRegisterStatus = firstRegisterStatus ?? false,
        secondRegisterStatus = secondRegisterStatus ?? false;

  final UserStatus status;
  final bool firstRegisterStatus;
  final bool secondRegisterStatus;

  @override
  // TODO: implement props
  List<Object> get props => [ status, firstRegisterStatus, secondRegisterStatus];

  UserState copyWith({
    UserStatus? status,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus

  }){
    return UserState(
        status: status ?? this.status,
        firstRegisterStatus: firstRegisterStatus ?? this.firstRegisterStatus,
        secondRegisterStatus: secondRegisterStatus ?? this.secondRegisterStatus
    );
  }
}