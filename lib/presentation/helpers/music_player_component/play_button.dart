// import 'package:flutter/material.dart';
// import 'package:simple_audio/simple_audio.dart';
// import '../../ui/main_page/navigation_bar_page/music_page.dart';
//
// class PlayButton extends StatefulWidget {
//
//   final bool isPlaying;
//   final SimpleAudio player;
//
//   PlayButton({super.key, required this.isPlaying, required this.player});
//
//   @override
//   State<PlayButton> createState() => _PlayButtonState(isPlaying, player);
// }
//
// class _PlayButtonState extends State<PlayButton> {
//
//   final bool isPlaying;
//   final SimpleAudio player;
//
//   _PlayButtonState(this.isPlaying, this.player);
//
//   @override
//   Widget build(BuildContext context) {
//     return CircleButton(
//       color: Colors.white30.withOpacity(0.2),
//       size: 50,
//       onPressed: () {
//         if (isPlaying) {
//           player.pause();
//         } else {
//           player.play();
//         }
//       },
//       child: Icon(
//         isPlaying
//             ? Icons.pause_rounded
//             : Icons.play_arrow_rounded,
//         color: Colors.white,
//         size: 40,
//       ),
//     );
//   }
// }