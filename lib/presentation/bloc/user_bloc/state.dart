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
    required this.user,
    required this.isExit
  });

  static UserState initial() => UserState(
    status: UserStatus.initial,
    firstRegisterStatus: false,
    secondRegisterStatus: false,
    user: UserModel(
      success: false,
      lastPage: 0,
      data: Data(
        id: 0,
        email: "",
        creationDate: "",
        isAdmin: false
      ),
      message: ""
    ),
    isExit: false
  );

  final UserStatus status;
  final bool firstRegisterStatus;
  final bool secondRegisterStatus;
  final UserModel user;
  final bool isExit;

  @override
  // TODO: implement props
  List<Object?> get props => [status, firstRegisterStatus,
    secondRegisterStatus, user, isExit];

  UserState copyWith({
    UserStatus? status,
    bool? firstRegisterStatus,
    bool? secondRegisterStatus,
    UserModel? user,
    bool? isExit
  }) {
    return UserState(
      status: status ?? this.status,
      firstRegisterStatus: firstRegisterStatus ?? this.firstRegisterStatus,
      secondRegisterStatus: secondRegisterStatus ?? this.secondRegisterStatus,
      user: user ?? this.user,
      isExit: isExit ?? this.isExit
    );
  }
}