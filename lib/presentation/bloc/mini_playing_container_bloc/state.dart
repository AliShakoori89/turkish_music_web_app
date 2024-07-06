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
    required this.visibility
  });

  static MiniPlayingContainerState initial() => const MiniPlayingContainerState(
    status: MiniPlayingContainerStatus.initial,
    visibility: false
  );

  final MiniPlayingContainerStatus status;
  final bool visibility;

  @override
  // TODO: implement props
  List<Object?> get props => [status, visibility];

  MiniPlayingContainerState copyWith({
    MiniPlayingContainerStatus? status,
    bool? visibility
  }) {
    return MiniPlayingContainerState(
      status: status ?? this.status,
      visibility: visibility ?? this.visibility
    );
  }
}