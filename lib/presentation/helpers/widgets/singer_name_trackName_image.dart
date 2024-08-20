import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

class SingerNameTrackNameImage extends StatelessWidget {

  final String songName;
  final String singerName;
  final String imagePath;
  final MainAxisAlignment align;

  const SingerNameTrackNameImage({super.key,
  required this.songName,
  required this.singerName,
  required this.imagePath,
  required this.align});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: align,
      children: [
        Expanded(
          flex: 1,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            imageBuilder: (context, imageProvider) => Container(
              // width: MediaQuery.of(context).size.width * 0.14,
              height: MediaQuery.of(context).size.height * 0.065,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.fill)
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                  child: OverflowTextAnimated(
                    text: songName,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    animation: OverFlowTextAnimations.infiniteLoop,
                    animateDuration: Duration(milliseconds: 1500),
                    delay: Duration(milliseconds: 500),
                  )
              ),
              DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white
                  ),
                  child: Text(singerName)
              )
            ],
          ),
        )
      ],
    );
  }
}
