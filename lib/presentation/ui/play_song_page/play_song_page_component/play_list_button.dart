import 'package:flutter/material.dart';

class PlayListButton extends StatelessWidget {
  const PlayListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Icon(
        size: MediaQuery.of(context).size.height / 40,
        Icons.playlist_play_outlined,
        color: Colors.grey,
      ),
    );
  }
}
