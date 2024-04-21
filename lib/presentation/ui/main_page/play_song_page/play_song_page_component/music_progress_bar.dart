import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_audio/simple_audio.dart';

class MusicProgressBar extends StatefulWidget {
  const MusicProgressBar({super.key});

  @override
  State<MusicProgressBar> createState() => _MusicProgressBarState();
}

class _MusicProgressBarState extends State<MusicProgressBar> {

  double position = 0;
  double duration = 0;

  PlaybackState playbackState = PlaybackState.stop;


  @override
  void initState() {
    super.initState();

    player.playbackStateStream.listen((event) async {
      setState(() => playbackState = event);
    });

    player.progressStateStream.listen((event) {
      setState(() {
        position = event.position.toDouble();
        duration = event.duration.toDouble();
      });
    });
  }

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

  String convertSecondsToReadableString(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;

    return "$m:${s > 9 ? s : "0$s"}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(convertSecondsToReadableString(position.floor())),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: SliderTheme(
              data: SliderThemeData(
                  activeTrackColor: Colors.grey,
                  thumbColor: Colors.grey.withOpacity(0.8)),
              child: Slider(
                value: min(position, duration),
                max: duration,
                onChanged: (value) {
                  player.seek(value.floor());
                },
              ),
            ),
          ),
        ),
        Text(convertSecondsToReadableString(duration.floor())),
      ],
    );
  }
}
