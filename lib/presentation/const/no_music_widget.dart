import 'dart:ui';

import 'package:flutter/material.dart';

class NoMusicWidget extends StatelessWidget {
  const NoMusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Image.asset("assets/custom_icons/no-music.png",
                color: Colors.white54,
                height: 100,
                width: 100,),
            )
        ),
        SizedBox(height: 5,),
        Text("No Song",
          style: TextStyle(color: Colors.white54),)
      ],
    );
  }
}
