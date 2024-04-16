import 'package:flutter/cupertino.dart';
import 'package:simple_audio/simple_audio.dart';

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