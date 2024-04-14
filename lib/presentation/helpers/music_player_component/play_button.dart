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
  State<PlayButton> createState() => PlayButtonState();
}

class PlayButtonState extends State<PlayButton> {

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      size: 60,
      onPressed: () async {
        if (widget.isPlaying) {
          widget.player.pause();
          await widget.audioPlayer.pause();
        } else {
          widget.player.play();
          await widget.audioPlayer.play(UrlSource(widget.musicFile!));
        }
      },
      child: Icon(
        widget.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
