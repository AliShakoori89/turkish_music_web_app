import 'package:flutter/material.dart';

class PlayingSongAnimation extends StatelessWidget {
  const PlayingSongAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/gif/playing music animation.gif"),
          scale: 0.2)),
    );
  }
}
