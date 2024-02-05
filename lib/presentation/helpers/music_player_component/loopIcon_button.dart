import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoopIconButton extends StatefulWidget {
  const LoopIconButton({super.key});

  @override
  State<LoopIconButton> createState() => _LoopIconButtonState();
}

class _LoopIconButtonState extends State<LoopIconButton> {

  bool isLoop = false;

  @override
  Widget build(BuildContext context) {

    return IconButton(
      padding: const EdgeInsets.all(0),
      splashRadius: 24,
      onPressed: () {
        setState(() {
          isLoop = !isLoop;
        });
      },
      icon: isLoop
          ? const Icon(
          CupertinoIcons.arrow_2_circlepath,
          color: Colors.white,
          size: 20,)
          : const Icon(
          CupertinoIcons.arrow_2_circlepath,
          color: Colors.grey,
          size: 20),
    );
  }
}
