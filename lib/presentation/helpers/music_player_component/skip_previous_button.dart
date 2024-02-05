import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page.dart';

class SkipPrevious extends StatelessWidget {
  const SkipPrevious({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      color: Colors.white30.withOpacity(0.2),
      size: 35,
      onPressed: (){

      },
      child: const Icon(
        Icons.skip_previous,
        color: Colors.white,
      ),
    );
  }
}
