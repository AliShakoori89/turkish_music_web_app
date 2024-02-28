import 'package:flutter/material.dart';

class UnderImageSingerAndSongName extends StatelessWidget {

  final String singerName;
  final String songName;
  final bool isArtist;

  const UnderImageSingerAndSongName({
    super.key, required this.singerName,
    required this.songName, required this.isArtist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 5,
          top: 5
      ),
      child: isArtist
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(songName,
              style: const TextStyle(
                  fontSize: 12
              )
          ),
          Text(singerName,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey
              )
          ),
        ],)
          : Text(singerName,
          style: const TextStyle(
              fontSize: 12
          )
      ),
    );
  }
}
