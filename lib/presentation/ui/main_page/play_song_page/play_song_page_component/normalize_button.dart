import 'package:flutter/material.dart';
import 'package:simple_audio/simple_audio.dart';

class NormalizeButton extends StatefulWidget {

  NormalizeButton({super.key});

  @override
  State<NormalizeButton> createState() => _NormalizeButtonState();
}

class _NormalizeButtonState extends State<NormalizeButton> {

  bool normalize = false;

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
        child: Container(
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: normalize
                ? Colors.white
                : Colors.white30.withOpacity(0.2),
          ),
          child: Transform.scale(
              scale: 2,
              child: IconButton(
                icon: ImageIcon(normalize
                    ? const AssetImage(
                    'assets/custom_icons/normalize.png')
                    : const AssetImage(
                    "assets/custom_icons/normalize_off.png")),
                onPressed: () {
                  setState(() {
                    normalize = !normalize;
                    player.normalizeVolume(normalize);
                  });
                },
              )),
        ));
  }
}
