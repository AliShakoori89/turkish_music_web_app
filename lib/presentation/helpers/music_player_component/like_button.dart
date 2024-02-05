import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final String name;
  final String track;
  final bool isIcon;
  const LikeButton({
    Key? key,
    required this.name,
    required this.track,
    required this.isIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

      return const Icon(
        CupertinoIcons.heart,
        color: Colors.grey,
      );

  }
}
