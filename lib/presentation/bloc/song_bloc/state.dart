import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import '../../../data/model/singer_model.dart';

enum SongStatus { initial, success, error, loading }

extension SongStatusX on SongStatus {
  bool get isInitial => this == SongStatus.initial;
  bool get isSuccess => this == SongStatus.success;
  bool get isError => this == SongStatus.error;
  bool get isLoading => this == SongStatus.loading;
}

class SongState extends Equatable{

  const SongState({
    required this.status,
    required this.songDetail
  });

  static SongState initial() => const SongState(
      status: SongStatus.initial,
      songDetail: null
  );

  final SongStatus status;
  final SongModel? songDetail;

  @override
  // TODO: implement props
  List<Object?> get props => [status, songDetail];

  SongState copyWith({
    SongStatus? status,
    SongModel? songDetail
  }) {
    return SongState(
      status: status ?? this.status,
      songDetail: songDetail ?? this.songDetail
    );
  }
}