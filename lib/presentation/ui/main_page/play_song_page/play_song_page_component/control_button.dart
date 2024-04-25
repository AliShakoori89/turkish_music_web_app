import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: () {
          },
        ),

        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 50.0,
                height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/gif/playing music animation.gif"))
                  ),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 50.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 50.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 50.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () {
          },
        ),
      ],
    );
  }
}