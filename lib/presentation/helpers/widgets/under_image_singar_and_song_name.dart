import 'package:flutter/material.dart';

class UnderImageSingerAndSongName extends StatelessWidget {

  final String singerName;
  String? songName;
  final bool isArtist;

  UnderImageSingerAndSongName({
    super.key, required this.singerName,
    this.songName, required this.isArtist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 2,
          top: 2
      ),
      child: isArtist
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(songName!, style: const TextStyle(fontSize: 12)),
                Text(singerName,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            )
          : Text(
              singerName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
            ),
    );
  }
}
