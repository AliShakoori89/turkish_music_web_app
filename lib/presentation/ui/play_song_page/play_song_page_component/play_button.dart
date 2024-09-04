import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/song_control_bloc/audio_control_bloc.dart';

class PlayButton extends StatefulWidget {
  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool playStatus = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.all(1),
        onPressed: () async {
          setState(() {
            playStatus = !playStatus;
            playStatus
                ? BlocProvider.of<AudioControlBloc>(context).add(PauseSongEvent())
                : BlocProvider.of<AudioControlBloc>(context).add(ResumeSongEvent());;
          });
        },
        icon: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 7.0,
              ),
              BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
            ]),
            child: !playStatus
                ? Icon(
              Icons.pause,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 20,)
                : Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 20,)));
  }
}
