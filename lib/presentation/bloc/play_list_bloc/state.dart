import 'package:equatable/equatable.dart';

enum PlayListStatus { initial, success, error, loading }

extension PlayListStatusX on PlayListStatus {
  bool get isInitial => this == PlayListStatus.initial;
  bool get isSuccess => this == PlayListStatus.success;
  bool get isError => this == PlayListStatus.error;
  bool get isLoading => this == PlayListStatus.loading;
}

class PlayListState extends Equatable{

  const PlayListState({
    required this.status,
  });

  static PlayListState initial() => const PlayListState(
      status: PlayListStatus.initial,
  );

  final PlayListStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  PlayListState copyWith({
    PlayListStatus? status,
  }) {
    return PlayListState(
        status: status ?? this.status,
    );
  }
}