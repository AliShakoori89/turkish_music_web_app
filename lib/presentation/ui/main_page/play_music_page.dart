import 'package:flutter/material.dart';

class PlayMusicPage extends StatelessWidget {
  
  final String imagePath;
  const PlayMusicPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/tarkan.png"),
          fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
      ),
    );
  }
}
