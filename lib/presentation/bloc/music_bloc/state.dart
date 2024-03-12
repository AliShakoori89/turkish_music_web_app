import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import '../../../data/model/singer_model.dart';

enum MusicStatus { initial, success, error, loading }

extension MusicStatusX on MusicStatus {
  bool get isInitial => this == MusicStatus.initial;
  bool get isSuccess => this == MusicStatus.success;
  bool get isError => this == MusicStatus.error;
  bool get isLoading => this == MusicStatus.loading;
}

class MusicState extends Equatable{

  const MusicState({
    required this.status,
  });

  static MusicState initial() => const MusicState(
      status: MusicStatus.initial,
  );

  final MusicStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  MusicState copyWith({
    MusicStatus? status,
  }) {
    return MusicState(
        status: status ?? this.status,
    );
  }
}