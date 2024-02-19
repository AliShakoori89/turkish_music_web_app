import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, success, error, loading }

extension RegisterStatusX on RegisterStatus {
  bool get isInitial => this == RegisterStatus.initial;
  bool get isSuccess => this == RegisterStatus.success;
  bool get isError => this == RegisterStatus.error;
  bool get isLoading => this == RegisterStatus.loading;
}

class RegisterState extends Equatable{

  const RegisterState ({
    this.status = RegisterStatus.initial,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus
  }): firstRegisterStatus = firstRegisterStatus ?? false,
        secondRegisterStatus = secondRegisterStatus ?? false;

  final RegisterStatus status;
  final bool firstRegisterStatus;
  final bool secondRegisterStatus;

  @override
  // TODO: implement props
  List<Object> get props => [ status, firstRegisterStatus, secondRegisterStatus];

  RegisterState copyWith({
    RegisterStatus? status,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus

  }){
    return RegisterState(
        status: status ?? this.status,
        firstRegisterStatus: firstRegisterStatus ?? this.firstRegisterStatus,
        secondRegisterStatus: secondRegisterStatus ?? this.secondRegisterStatus
    );
  }
}