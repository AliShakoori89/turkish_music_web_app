import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class RandomPlayButton extends StatefulWidget {
  const RandomPlayButton({super.key});

  @override
  State<RandomPlayButton> createState() => _RandomPlayButtonState();
}

class _RandomPlayButtonState extends State<RandomPlayButton> {

  bool isRandom = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      splashRadius: 24,
      onPressed: () {
        setState(() {
          isRandom = !isRandom;
        });
      },
      icon: isRandom
          ? const Icon(
          LineIcons.random,
          color: Colors.white,
          size: 20)
          : const Icon(
          LineIcons.random,
          color: Colors.grey,
          size: 20),
    );
  }
}
