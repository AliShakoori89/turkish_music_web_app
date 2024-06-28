import 'package:flutter/material.dart';
import '../../../helpers/widgets/home_page/new_music_container/new_music_container.dart';
import '../../../helpers/widgets/header.dart';
import '../../../helpers/widgets/home_page/category_item.dart';
import '../../../helpers/widgets/home_page/new_album_contaner.dart';
import '../../../helpers/widgets/home_page/singer_container.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                NewMusicContainer(),
                SingerContainer(),
                NewAlbumContainer(),
                CategoryItemContainer()
              ],
            ),
          ),
        )
      ),
    );
  }
}
