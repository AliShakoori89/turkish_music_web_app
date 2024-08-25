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
          ? Icon(
        size: MediaQuery.of(context).size.height / 40,
        Icons.loop,
        color: Colors.white,
      )
          : Icon(
        size: MediaQuery.of(context).size.height / 40,
          Icons.loop,
          color: Colors.grey),
    );
  }
}
