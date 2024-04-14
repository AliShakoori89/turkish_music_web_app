// import 'package:flutter/material.dart';
// import 'package:simple_audio/simple_audio.dart';
// import '../widgets/circle_button.dart';
//
// class VolumeButton extends StatefulWidget {
//   const VolumeButton({super.key});
//
//   @override
//   State<VolumeButton> createState() => _VolumeButtonState();
// }
//
// class _VolumeButtonState extends State<VolumeButton> {
//
//   bool get isMuted => volume == 0;
//   double volume = 1;
//   double trueVolume = 1;
//
//   final SimpleAudio player = SimpleAudio(
//     onSkipNext: (_) => debugPrint("Next"),
//     onSkipPrevious: (_) => debugPrint("Prev"),
//     onNetworkStreamError: (player, error) {
//       debugPrint("Network Stream Error: $error");
//       player.stop();
//     },
//     onDecodeError: (player, error) {
//       debugPrint("Decode Error: $error");
//       player.stop();
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return CircleButton(
//       color: Colors.white30.withOpacity(0.2),
//       size: 35,
//       onPressed: () {
//         if (!isMuted) {
//           player.setVolume(0);
//           setState(() => volume = 0);
//         } else {
//           player.setVolume(trueVolume);
//           setState(() => volume = trueVolume);
//         }
//       },
//       child: Icon(
//         isMuted ? Icons.volume_off : Icons.volume_up,
//         color: Colors.white,
//       ),
//     );
//   }
// }