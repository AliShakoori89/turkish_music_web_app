import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/state.dart';
import '../../bloc/is_playing_music_bloc/bloc.dart';
import '../../bloc/is_playing_music_bloc/event.dart';
import '../widgets/circle_button.dart';
import 'package:turkish_music_app/presentation/helpers/global.dart' as global;

class PlayButton extends StatefulWidget {
  PlayButton({super.key,
    required this.isPlaying,
    required this.player,
    required this.audioPlayer,
    required this.musicFile,
    required this.musicSingerName,
    required this.imagePath});

  final bool isPlaying;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;
  String musicFile;
  String musicSingerName;
  String imagePath;

  @override
  State<PlayButton> createState() => PlayButtonState();
}

class PlayButtonState extends State<PlayButton> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<IsPlayingMusicBloc>(context)
        .add(GetIsPlayingMusicEvent());
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<IsPlayingMusicBloc, IsPlayingMusicState>(
        builder: (context, state) {
      var musicFile = state.musicFile;

      print("11111         " + musicFile);
      print("22222         " + widget.musicFile);

      return musicFile == widget.musicFile
          ?  CircleButton(
              size: 60,
              onPressed: () async {

                BlocProvider.of<IsPlayingMusicBloc>(context)
                    .add(SetIsPlayingMusicEvent(
                  musicFilePath: widget.musicFile,
                  singerName: widget.musicSingerName,
                  imagePath: widget.imagePath,
                  isPlaying: widget.isPlaying,
                ));

                if (widget.isPlaying) {

                  BlocProvider.of<IsPlayingMusicBloc>(context)
                      .add(GetIsPlayingMusicEvent());

                  print("pause");
                  widget.player.pause();
                  await widget.audioPlayer.pause();
                } else {

                  BlocProvider.of<IsPlayingMusicBloc>(context)
                      .add(GetIsPlayingMusicEvent());

                  print("play");
                  widget.player.play();
                  await widget.audioPlayer.play(UrlSource(widget.musicFile));
                }

              },
              child:  BlocBuilder<IsPlayingMusicBloc, IsPlayingMusicState>(
                  builder: (context, state) {
                    var isPlaying = state.isPlaying;

                    return Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 50,
                );
             }))
          : CircleButton(
              size: 60,
              onPressed: () async {
                BlocProvider.of<IsPlayingMusicBloc>(context)
                    .add(SetIsPlayingMusicEvent(
                  musicFilePath: widget.musicFile,
                  singerName: widget.musicSingerName,
                  imagePath: widget.imagePath,
                  isPlaying: widget.isPlaying,
                ));

                if (widget.isPlaying) {
                  widget.player.pause();
                  await widget.audioPlayer.pause();
                } else {
                  widget.player.play();
                  await widget.audioPlayer.play(UrlSource(widget.musicFile));
                }
              },
              child: Icon(
                widget.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 50,
              ));
    });
  }
}

