import 'package:equatable/equatable.dart';

enum InternetConnectionStatus { initial, success, error, loading }

extension InternetConnectionStatusX on InternetConnectionStatus {
  bool get isInitial => this == InternetConnectionStatus.initial;
  bool get isSuccess => this == InternetConnectionStatus.success;
  bool get isError => this == InternetConnectionStatus.error;
  bool get isLoading => this == InternetConnectionStatus.loading;
}

class InternetConnectionState extends Equatable{

  const InternetConnectionState({
    required this.status,
    required this.internetConnectionStatus
  });

  static InternetConnectionState initial() => const InternetConnectionState(
    status: InternetConnectionStatus.initial,
    internetConnectionStatus: false
  );

  final InternetConnectionStatus status;
  final bool internetConnectionStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [status, internetConnectionStatus];

  InternetConnectionState copyWith({
    InternetConnectionStatus? status,
    bool? internetConnectionStatus
  }) {
    return InternetConnectionState(
        status: status ?? this.status,
        internetConnectionStatus: internetConnectionStatus ?? this.internetConnectionStatus
    );
  }
}