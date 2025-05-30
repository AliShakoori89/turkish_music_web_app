import 'package:flutter/material.dart';
import '../../../../helpers/widgets/header.dart';
import 'home_page_component/categories/category_item.dart';
import 'home_page_component/new_album_contaner.dart';
import 'home_page_component/new_song_container/new_song_container.dart';
import 'home_page_component/singer_container/singer_container.dart';

class HomePage extends StatelessWidget {

  static String routeName = "HomePage";

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(),
                  NewMusicContainer(),
                  SingerContainer(),
                  NewAlbumContainer(),
                  CategoryItemContainer(),
                  SizedBox(
                    height: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.02
                        : MediaQuery.of(context).size.height * 0.1,
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
