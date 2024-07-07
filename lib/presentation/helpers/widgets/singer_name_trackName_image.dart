import 'package:flutter/material.dart';

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
        Container(
          width: MediaQuery.of(context).size.width * 0.14,
          height: MediaQuery.of(context).size.height * 0.065,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.fill)
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white
                ),
                child: Text(songName)
            ),
            DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white
                ),
                child: Text(singerName)
            )
          ],
        )
      ],
    );
  }
}
