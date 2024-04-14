import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_audio/simple_audio.dart';

enum IsPlayingMusicStatus { initial, success, error, loading }

extension MIsPlayingMusicStatusX on IsPlayingMusicStatus {
  bool get isInitial => this == IsPlayingMusicStatus.initial;
  bool get isSuccess => this == IsPlayingMusicStatus.success;
  bool get isError => this == IsPlayingMusicStatus.error;
  bool get isLoading => this == IsPlayingMusicStatus.loading;
}

class IsPlayingMusicState extends Equatable{

  const IsPlayingMusicState({
    required this.status,
    required this.musicFile,
    required this.singerName,
    required this.singerImage,
  });

  static IsPlayingMusicState initial() => const IsPlayingMusicState(
    status: IsPlayingMusicStatus.initial,
    musicFile: '',
    singerName: '',
    singerImage: '',
  );

  final IsPlayingMusicStatus status;
  final String musicFile;
  final String singerName;
  final String singerImage;

  @override
  // TODO: implement props
  List<Object?> get props => [status, musicFile, singerName, singerImage];

  IsPlayingMusicState copyWith({
    IsPlayingMusicStatus? status,
    String? musicFile,
    String? singerName,
    String? singerImage
  }) {
    return IsPlayingMusicState(
      status: status ?? this.status,
      musicFile: musicFile ?? this.musicFile,
      singerName: singerName ?? this.singerName,
      singerImage: singerImage ?? this.singerImage
    );
  }
}