import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_audio/simple_audio.dart';
import '../widgets/circle_button.dart';

class PlayButton extends StatefulWidget {
  PlayButton({super.key,
    required this.isPlaying,
    required this.player,
    required this.audioPlayer,
    this.musicFile});

  final bool isPlaying;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;
  String? musicFile;

  @override
  State<PlayButton> createState() => PlayButtonState(isPlaying, player, audioPlayer, musicFile);
}

class PlayButtonState extends State<PlayButton> {

  PlayButtonState(this.isPlaying, this.player, this.audioPlayer, this.musicFile);

  final bool isPlaying;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;
  String? musicFile;

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      size: 60,
      onPressed: () async {
        print("*******             " + isPlaying.toString());
        print("*******             " + player.toString());
        print("*******             " + audioPlayer.playerId);
        if (isPlaying) {
          player.pause();
          await audioPlayer.pause();
        } else {
          player.play();
          await audioPlayer.play(UrlSource(musicFile!));
        }
      },
      child: Icon(
        isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
