import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepeatButton extends StatelessWidget {

  final bool loop;
  const RepeatButton({super.key, required this.loop});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      splashRadius: 24,
      onPressed: () {

      },
      icon: loop
          ? const Icon(
        CupertinoIcons.arrow_2_circlepath,
        color: Colors.white,
        size: 20,
      )
          : const Icon(
          CupertinoIcons.arrow_2_circlepath,
          color: Colors.grey, size: 20),
    );
  }
}
