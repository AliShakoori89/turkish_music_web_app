import 'package:audioplayers/audioplayers.dart';
import 'package:simple_audio/simple_audio.dart';

abstract class IsPlayingMusicEvent {
  List<Object> get props => [];
}

class SetIsPlayingMusicEvent extends IsPlayingMusicEvent{
  final String musicFilePath;
  final String singerName;
  final String imagePath;
  final AudioPlayer audioPlayer;
  final bool isPlaying;

  SetIsPlayingMusicEvent({
    required this.musicFilePath,
    required this.singerName,
    required this.imagePath,
    required this.audioPlayer,
    required this.isPlaying});

  @override
  List<Object> get props => [musicFilePath, singerName, imagePath, audioPlayer, isPlaying];
}

class GetIsPlayingMusicEvent extends IsPlayingMusicEvent{

  GetIsPlayingMusicEvent();

  @override
  List<Object> get props => [];
}