import 'package:flutter/material.dart';
import 'package:simple_audio/simple_audio.dart';
import '../../../../helpers/widgets/circle_button.dart';

class StopButton extends StatelessWidget {
  StopButton({super.key});

  PlaybackState playbackState = PlaybackState.stop;
  bool get isPlaying =>
      playbackState == PlaybackState.play ||
          playbackState == PlaybackState.preloadPlayed;

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
    return CircleButton(
      color: Colors.white30.withOpacity(0.2),
      size: 35,
      onPressed: playbackState != PlaybackState.done
          ? player.stop
          : null,
      child: const Icon(Icons.stop, color: Colors.white),
    );
  }
}