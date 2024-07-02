import 'package:flutter/material.dart';

import '../widgets/circle_button.dart';

class SkipNext extends StatelessWidget {
  const SkipNext({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      color: Colors.white30.withOpacity(0.3),
      size: 35,
      onPressed:(){

      },
      child: const Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
    );
  }
}
