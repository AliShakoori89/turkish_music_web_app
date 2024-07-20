import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loopButton extends StatefulWidget {

  @override
  State<loopButton> createState() => _loopButtonState();
}

class _loopButtonState extends State<loopButton> {

  bool loop = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      splashRadius: 24,
      onPressed: () {
        setState(() {
          loop = !loop;
        });
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
