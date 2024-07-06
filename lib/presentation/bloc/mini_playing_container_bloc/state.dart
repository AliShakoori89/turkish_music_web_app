import 'package:equatable/equatable.dart';

enum MiniPlayingContainerStatus { initial, success, error, loading }

extension MiniPlayingContainerStatusX on MiniPlayingContainerStatus {
  bool get isInitial => this == MiniPlayingContainerStatus.initial;
  bool get isSuccess => this == MiniPlayingContainerStatus.success;
  bool get isError => this == MiniPlayingContainerStatus.error;
  bool get isLoading => this == MiniPlayingContainerStatus.loading;
}

class MiniPlayingContainerState extends Equatable{

  const MiniPlayingContainerState({
    required this.status,
  });

  static MiniPlayingContainerState initial() => const MiniPlayingContainerState(
    status: MiniPlayingContainerStatus.initial,
  );

  final MiniPlayingContainerStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  MiniPlayingContainerState copyWith({
    MiniPlayingContainerStatus? status,
  }) {
    return MiniPlayingContainerState(
        status: status ?? this.status,
    );
  }
}