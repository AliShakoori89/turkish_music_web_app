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
      splashRadius: 24,
      onPressed: () {
        setState(() {
          loop = !loop;
        });
      },
      icon: loop
          ? const Icon(
        Icons.loop,
        color: Colors.white,
      )
          : const Icon(
          Icons.loop,
          color: Colors.grey),
    );
  }
}
