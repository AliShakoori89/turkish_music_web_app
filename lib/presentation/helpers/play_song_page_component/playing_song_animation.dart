import 'package:flutter/material.dart';

class PlayingSongAnimation extends StatelessWidget {
  const PlayingSongAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/gif/playing music animation.gif"))),
    );
  }
}
