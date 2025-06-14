import 'package:equatable/equatable.dart';

enum RegUserExistStatus { initial, success, error, loading }

extension USerExistStatusX on RegUserExistStatus {
  bool get isInitial => this == RegUserExistStatus.initial;
  bool get isSuccess => this == RegUserExistStatus.success;
  bool get isError => this == RegUserExistStatus.error;
  bool get isLoading => this == RegUserExistStatus.loading;
}

class RegUserExistState extends Equatable{

  const RegUserExistState({
    required this.status,
    required this.userExistMessage,
    required this.userExistStatus
  });

  static RegUserExistState initial() => RegUserExistState(
    status: RegUserExistStatus.initial,
    userExistMessage: '',
    userExistStatus: false
  );

  final RegUserExistStatus status;
  final String userExistMessage;
  final bool userExistStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [status, userExistMessage, userExistStatus];

  RegUserExistState copyWith({
    RegUserExistStatus? status,
    String? userExist,
    bool? userStatus

  }) {
    return RegUserExistState(
      status: status ?? this.status,
      userExistMessage: userExist ?? this.userExistMessage,
      userExistStatus: userStatus ?? this.userExistStatus
    );
  }
}