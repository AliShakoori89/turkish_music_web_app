import 'package:flutter/material.dart';

class NoMusicWidget extends StatelessWidget {
  const NoMusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Image.asset("assets/custom_icons/no-music.png",
              color: Colors.white54,
              opacity: const AlwaysStoppedAnimation(.3),
              height: 100,
              width: 100,)
        ),
        SizedBox(height: 5,),
        Text("No Song",
          style: TextStyle(color: Colors.white54),)
      ],
    );
  }
}
