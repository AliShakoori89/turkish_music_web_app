import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/no_image.dart';

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

    Orientation orientation = MediaQuery.of(context).orientation;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: align,
      children: [
        Expanded(
          flex: 1,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            imageBuilder: (context, imageProvider) => Container(
              width: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.11
                  : MediaQuery.of(context).size.width / 9,
              height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.065
                  : MediaQuery.of(context).size.height / 9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.fill)
              ),
            ),
            errorWidget: (context, url, error) => NoImage(),
          )
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
        Expanded(
          flex: orientation == Orientation.portrait
              ? 4
              : 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                  child: Text(
                    songName,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
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
