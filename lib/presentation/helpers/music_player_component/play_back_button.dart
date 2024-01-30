import 'package:flutter/material.dart';
import 'package:simple_audio/simple_audio.dart';

class PlayBackButton extends StatefulWidget {
  const PlayBackButton({super.key});

  @override
  State<PlayBackButton> createState() => _PlayBackButtonState();
}

class _PlayBackButtonState extends State<PlayBackButton> {
  bool loop = false;

  final SimpleAudio player = SimpleAudio(
    onSkipNext: (_) => debugPrint("Next"),
    onSkipPrevious: (_) => debugPrint("Prev"),
    onNetworkStreamError: (player, error) {
      debugPrint("Network Stream Error: $error");
      player.stop();
    },
    onDecodeError: (player, error) {
      debugPrint("Decode Error: $error");
      player.stop();
    },
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
          onTap: () {
            setState(() {
              loop = !loop;
              player.loopPlayback(loop);
            });
          },
          child: Container(
            width: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: loop
                    ? Colors.white
                    : Colors.white30.withOpacity(0.2)),
            padding: const EdgeInsets.all(5),
            child: loop
                ? const Icon(
              Icons.repeat,
              size: 15.0,
              color: Colors.black,
            )
                : const Icon(
              Icons.repeat,
              size: 15.0,
              color: Colors.white,
            ),
          ),
        ));
  }
}