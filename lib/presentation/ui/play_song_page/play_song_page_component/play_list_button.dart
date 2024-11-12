import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main_page/navigation_bar_page/song_page/playlist_page.dart';

class PlayListButton extends StatelessWidget {
  const PlayListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push(
            '/'+PlaylistPage.routeName);
      },
      child: Icon(
        size: MediaQuery.of(context).size.height / 40,
        Icons.playlist_play_outlined,
        color: Colors.grey,
      ),
    );
  }
}
