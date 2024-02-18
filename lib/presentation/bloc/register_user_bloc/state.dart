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
    bool? registerStatus
  }): registerStatus = registerStatus ?? false;

  final RegisterStatus status;
  final bool registerStatus;

  @override
  // TODO: implement props
  List<Object> get props => [ status, registerStatus];

  RegisterState copyWith({
    RegisterStatus? status,
    bool? registerStatus

  }){
    return RegisterState(
        status: status ?? this.status,
        registerStatus: registerStatus ?? this.registerStatus
    );
  }
}