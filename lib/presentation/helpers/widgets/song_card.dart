import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {

  final String songName;
  final String imgPath;
  final String singerName;

  const SongCard({super.key, required this.songName, required this.imgPath, required this.singerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(imgPath),
                    fit: BoxFit.cover)),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoScrollText(
              songName,
              mode: AutoScrollTextMode.endless,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
                singerName,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54
                )
            )
          ],
        ),
      ],
  );
  }
}
