import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnderImageSingerAndSongName extends StatelessWidget {

  final String singerName;
  String? albumName;
  final bool isArtist;

  UnderImageSingerAndSongName({
    super.key, required this.singerName,
    this.albumName, required this.isArtist});

  @override
  Widget build(BuildContext context) {
    return isArtist
        ? Padding(
          padding: const EdgeInsets.only(
            top: 2
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      albumName!,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    )),
                Expanded(
                  flex: 1,
                  child: Text(singerName,
                      style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ),
                Spacer()
              ],
            ),
        )
        : Text(
      singerName,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 12),
      maxLines: 1,
    );
  }
}
