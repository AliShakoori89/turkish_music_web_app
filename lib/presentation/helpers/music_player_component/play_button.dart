import 'package:flutter/material.dart';
import 'package:simple_audio/simple_audio.dart';
import '../../ui/main_page/navigation_bar_page/music_page.dart';

class PlayButton extends StatelessWidget {
  PlayButton({super.key});

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
      size: 40,
      onPressed: () {
        if (isPlaying) {
          player.pause();
        } else {
          player.play();
        }
      },
      child: Icon(
        isPlaying
            ? Icons.pause_rounded
            : Icons.play_arrow_rounded,
        color: Colors.white,
      ),
    );
  }
}