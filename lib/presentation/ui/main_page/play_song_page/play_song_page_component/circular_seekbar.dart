import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';

class CustomCircularSeekBar extends StatelessWidget {

  final String songImage;
  const CustomCircularSeekBar({super.key, required this.songImage});

  @override
  Widget build(BuildContext context) {
    return CircularSeekBar(
      width: double.infinity,
      height: 350,
      progress: 100,
      barWidth: 8,
      startAngle: 45,
      sweepAngle: 270,
      strokeCap: StrokeCap.butt,
      progressGradientColors: const [
        Colors.blue,
        Colors.indigo,
        Colors.purple
      ],
      dashWidth: 1,
      dashGap: 2,
      animation: true,
      animDurationMillis: 10000,

      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(songImage),
                fit: BoxFit.fitHeight)),
      ),
      // maxProgress: 120,
      // minProgress: 0,
    );
  }
}
