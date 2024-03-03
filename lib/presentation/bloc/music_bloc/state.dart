import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
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
    required this.famousArtist,
    required this.newSong
  });

  static MusicState initial() => const MusicState(
      status: MusicStatus.initial,
      famousArtist: <SingerDataModel>[],
      newSong: <NewMusicDataModel>[]
  );

  final MusicStatus status;
  final List<SingerDataModel> famousArtist;
  final List<NewMusicDataModel> newSong;

  @override
  // TODO: implement props
  List<Object?> get props => [status, famousArtist];

  MusicState copyWith({
    MusicStatus? status,
    List<SingerDataModel>? famousArtist,
    List<NewMusicDataModel>? newSong
  }) {
    return MusicState(
        status: status ?? this.status,
        famousArtist: famousArtist ?? this.famousArtist,
        newSong: newSong ?? this.newSong
    );
  }
}