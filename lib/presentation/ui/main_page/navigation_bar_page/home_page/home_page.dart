import 'package:flutter/material.dart';
import '../../../../helpers/widgets/header.dart';
import 'home_page_component/category_item.dart';
import 'home_page_component/new_album_contaner.dart';
import 'home_page_component/new_music_container/new_music_container.dart';
import 'home_page_component/singer_container/singer_container.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(),
                  NewMusicContainer(),
                  SingerContainer(),
                  NewAlbumContainer(),
                  CategoryItemContainer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
