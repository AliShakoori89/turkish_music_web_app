import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/song_control_bloc/audio_control_bloc.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioControlBloc, AudioControlState>(
      buildWhen: (previous, current) {
        if (previous is AudioPlayedState && current is AudioPlayedState) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        return IconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () async {
              if (state is AudioPausedState) {
                BlocProvider.of<AudioControlBloc>(context).add(ResumeSong());
              } else {
                BlocProvider.of<AudioControlBloc>(context).add(PauseSong());
              }
            },
            icon: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 7.0,
                  ),
                  BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
                ]),
                child: state is AudioPlayedState
                    ? const Icon(
                  Icons.pause,
                  color: Colors.white,
                  size: 40,)
                    : const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40,)));
      },
    );
  }
}
