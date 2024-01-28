import 'package:flutter/material.dart';
import '../../../helpers/featured_container.dart';
import '../../../helpers/header.dart';
import '../../../helpers/must_listen_contaner.dart';
import '../../../helpers/new_song_contaner.dart';
import '../../../helpers/playlist_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: const SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(),
              PlaylistContainer(),
              FeaturedContainer(),
              NewSong(),
              MustListenContainer()
            ],
          ),
        ),
      ),
    );
  }
}
