import 'package:equatable/equatable.dart';

enum IsPlayingMusicStatus { initial, success, error, loading }

extension MIsPlayingMusicStatusX on IsPlayingMusicStatus {
  bool get isInitial => this == IsPlayingMusicStatus.initial;
  bool get isSuccess => this == IsPlayingMusicStatus.success;
  bool get isError => this == IsPlayingMusicStatus.error;
  bool get isLoading => this == IsPlayingMusicStatus.loading;
}

class IsPlayingMusicState extends Equatable{

  const IsPlayingMusicState({
    required this.status
  });

  static IsPlayingMusicState initial() => const IsPlayingMusicState(
      status: IsPlayingMusicStatus.initial,
  );

  final IsPlayingMusicStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  IsPlayingMusicState copyWith({
    IsPlayingMusicStatus? status,
  }) {
    return IsPlayingMusicState(
        status: status ?? this.status,
    );
  }
}