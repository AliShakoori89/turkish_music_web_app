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
    required this.visibility,
    required this.requirement
  });

  static MiniPlayingContainerState initial() => const MiniPlayingContainerState(
    status: MiniPlayingContainerStatus.initial,
    visibility: false,
    requirement: []
  );

  final MiniPlayingContainerStatus status;
  final bool visibility;
  final List requirement;

  @override
  // TODO: implement props
  List<Object?> get props => [status, visibility, requirement];

  MiniPlayingContainerState copyWith({
    MiniPlayingContainerStatus? status,
    bool? visibility,
    List? requirement
  }) {
    return MiniPlayingContainerState(
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      requirement:  requirement ?? this.requirement
    );
  }
}