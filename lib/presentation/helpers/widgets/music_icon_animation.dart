import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

import '../../const/custom_icon/music_icons.dart';

class MusicIconAnimation extends StatelessWidget {
  const MusicIconAnimation({super.key, required this.topValue, required this.leftValue,
  required this.iconSize, required this.animation, required this.icon});

  final double topValue;
  final double leftValue;
  final double iconSize;
  final Animation<double> animation;
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Positioned(
      top: size.height * (animation.value + topValue),
      left: size.width * leftValue,
      child: GradientIcon(
        icon: icon,
        gradient: const LinearGradient(
          colors: [Color(0xffb188ef), Color(0xff5b07bb)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        size: iconSize,
      ),
    );
  }
}
