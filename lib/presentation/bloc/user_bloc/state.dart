import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/user_model.dart';

enum UserStatus { initial, success, error, loading }

extension UserStatusX on UserStatus {
  bool get isInitial => this == UserStatus.initial;
  bool get isSuccess => this == UserStatus.success;
  bool get isError => this == UserStatus.error;
  bool get isLoading => this == UserStatus.loading;
}

class UserState extends Equatable{

  const UserState({
    required this.status, required this.firstRegisterStatus,
    required this.secondRegisterStatus,
    required this.user
  });

  static UserState initial() => const UserState(
    status: UserStatus.initial,
    firstRegisterStatus: false,
    secondRegisterStatus: false,
    user: null
  );

  final UserStatus status;
  final bool firstRegisterStatus;
  final bool secondRegisterStatus;
  final UserModel? user;

  @override
  // TODO: implement props
  List<Object?> get props => [status, firstRegisterStatus,
    secondRegisterStatus, user];

  UserState copyWith({
    UserStatus? status,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus,
    UserModel? user,
  }) {
    return UserState(
        status: status ?? this.status,
        firstRegisterStatus: firstRegisterStatus ?? this.firstRegisterStatus,
        secondRegisterStatus: secondRegisterStatus ?? this.secondRegisterStatus,
        user: user ?? this.user
    );
  }
}