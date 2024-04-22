import 'package:equatable/equatable.dart';

enum SongTimeStatus { initial, success, error, loading }

extension SongTimeStatusX on SongTimeStatus {
  bool get isInitial => this == SongTimeStatus.initial;
  bool get isSuccess => this == SongTimeStatus.success;
  bool get isError => this == SongTimeStatus.error;
  bool get isLoading => this == SongTimeStatus.loading;
}

class SongDurationState extends Equatable{

  const SongDurationState({
    required this.status,
    required this.songDuration
  });

  static SongDurationState initial() => const SongDurationState(
    status: SongTimeStatus.initial,
    songDuration: 0.0

  );

  final SongTimeStatus status;
  final double songDuration;

  @override
  // TODO: implement props
  List<Object?> get props => [status, songDuration];

  SongDurationState copyWith({
    SongTimeStatus? status,
    double? songDuration
  }) {
    return SongDurationState(
      status: status ?? this.status,
      songDuration: songDuration ?? this.songDuration
    );
  }
}