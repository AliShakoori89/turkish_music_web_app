import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/music_model.dart';
import 'package:turkish_music_app/data/model/user_model.dart';

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
    required this.famousArtist
  });

  static MusicState initial() => const MusicState(
      status: MusicStatus.initial,
      famousArtist: [],
  );

  final MusicStatus status;
  final List<Singer> famousArtist;

  @override
  // TODO: implement props
  List<Object?> get props => [status, famousArtist];

  MusicState copyWith({
    MusicStatus? status,
    List<Singer>? famousArtist
  }) {
    return MusicState(
        status: status ?? this.status,
        famousArtist: famousArtist ?? this.famousArtist
    );
  }
}