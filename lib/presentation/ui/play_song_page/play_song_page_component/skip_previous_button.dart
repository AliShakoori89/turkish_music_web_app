import 'package:flutter/material.dart';

import '../../../helpers/widgets/circle_button.dart';

class SkipPrevious extends StatelessWidget {
  const SkipPrevious({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      color: Colors.white30.withValues(alpha: 0.3),
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
