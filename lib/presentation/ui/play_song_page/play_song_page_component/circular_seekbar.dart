import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../generated/assets.dart';
import '../../../const/no_image.dart';

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
        margin: EdgeInsets.all(20),
        child: CachedNetworkImage(
          imageUrl: songImage,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.grey[400]!,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2
            ),
          ),
          errorWidget: (context, url, error) => NoImage(),
        ),
      ),
    );
  }
}
