import 'package:flutter/material.dart';

class PlayListButton extends StatelessWidget {
  const PlayListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: const Icon(
        Icons.playlist_play_outlined,
        color: Colors.grey,
      ),
    );
  }
}
