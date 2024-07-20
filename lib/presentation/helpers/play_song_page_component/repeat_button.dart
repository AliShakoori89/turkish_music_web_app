import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/song_control_bloc/audio_control_bloc.dart';

class repeatButton extends StatefulWidget {

  @override
  State<repeatButton> createState() => _repeatButtonState();
}

class _repeatButtonState extends State<repeatButton> {

  bool repeat = false;
  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      splashRadius: 24,
      onPressed: () {
        setState(() {
          repeat = !repeat;
        });
        if (repeat) {
          BlocProvider.of<AudioControlBloc>(context).add(RepeatSong());
        }else{
          BlocProvider.of<AudioControlBloc>(context).add(StopRepeating());
        }
      },
      icon: repeat
          ? const Icon(
        Icons.repeat,
        color: Colors.white,
        size: 20,
      )
          : const Icon(Icons.repeat, color: Colors.grey, size: 20),
    );
  }
}
