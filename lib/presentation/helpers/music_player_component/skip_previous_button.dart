import 'package:flutter/material.dart';
import '../widgets/circle_button.dart';

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
