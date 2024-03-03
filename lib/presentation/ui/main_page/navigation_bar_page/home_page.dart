import 'package:flutter/material.dart';
import '../../../helpers/widgets/home_page/new_music_container.dart';
import '../../../helpers/widgets/header.dart';
import '../../../helpers/widgets/must_listen_contaner.dart';
import '../../../helpers/widgets/home_page/new_album_contaner.dart';
import '../../../helpers/widgets/home_page/famous_artist_container.dart';

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
              NewMusicContainer(),
              FamousArtistContainer(),
              NewAlbumContainer(),
              MustListenContainer()
            ],
          ),
        ),
      ),
    );
  }
}
