import 'package:equatable/equatable.dart';

enum ChangeSignUpToLoginPageStatus { initial, success, error, loading }

extension ChangeSignUpToLoginPageStatusX on ChangeSignUpToLoginPageStatus {
  bool get isInitial => this == ChangeSignUpToLoginPageStatus.initial;
  bool get isSuccess => this == ChangeSignUpToLoginPageStatus.success;
  bool get isError => this == ChangeSignUpToLoginPageStatus.error;
  bool get isLoading => this == ChangeSignUpToLoginPageStatus.loading;
}

class ChangeSignUpToLoginPageState extends Equatable{

  const ChangeSignUpToLoginPageState ({
    this.status = ChangeSignUpToLoginPageStatus.initial,
    bool? isSignUp
  }): isSignUp = isSignUp ?? false;

  final ChangeSignUpToLoginPageStatus status;
  final bool isSignUp;

  @override
  // TODO: implement props
  List<Object> get props => [ status];

  ChangeSignUpToLoginPageState copyWith({
  ChangeSignUpToLoginPageStatus? status,
  bool? isSignUp
  }){
    return ChangeSignUpToLoginPageState(
      status: status ?? this.status,
      isSignUp: isSignUp ?? this.isSignUp
    );
  }
}