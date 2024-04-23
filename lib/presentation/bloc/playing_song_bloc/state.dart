import 'package:equatable/equatable.dart';
import 'package:simple_audio/simple_audio.dart';

enum PlayingSongStatus { initial, success, error, loading }

extension MIsPlayingSongStatusX on PlayingSongStatus {
  bool get isInitial => this == PlayingSongStatus.initial;
  bool get isSuccess => this == PlayingSongStatus.success;
  bool get isError => this == PlayingSongStatus.error;
  bool get isLoading => this == PlayingSongStatus.loading;
}

class PlayingSongState extends Equatable{

  const PlayingSongState({
    required this.status,
    required this.songFile,
    required this.singerName,
    required this.singerImage,
    required this.previousSongFile,
    required this.isPlaying
  });

  static PlayingSongState initial() => const PlayingSongState(
    status: PlayingSongStatus.initial,
    songFile: '',
    singerName: '',
    singerImage: '',
    previousSongFile: '',
    isPlaying: false
  );

  final PlayingSongStatus status;
  final String songFile;
  final String singerName;
  final String singerImage;
  final String previousSongFile;
  final bool isPlaying;

  @override
  // TODO: implement props
  List<Object?> get props => [status, songFile, singerName, singerImage, previousSongFile, isPlaying];

  PlayingSongState copyWith({
    PlayingSongStatus? status,
    String? songFile,
    String? singerName,
    String? singerImage,
    String? previousSongFile,
    bool? isPlaying
  }) {
    return PlayingSongState(
      status: status ?? this.status,
      songFile: songFile ?? this.songFile,
      singerName: singerName ?? this.singerName,
      singerImage: singerImage ?? this.singerImage,
      previousSongFile: previousSongFile ?? this.previousSongFile,
      isPlaying: isPlaying ?? this.isPlaying
    );
  }
}