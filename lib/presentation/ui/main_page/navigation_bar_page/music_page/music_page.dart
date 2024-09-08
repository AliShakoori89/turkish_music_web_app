import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_page_with_cards.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page/recently_played_list.dart';

class MusicPage extends StatelessWidget {

  List customIcon = [
    Icons.playlist_play_outlined,
    Icons.download,
  ];
  List title = [
    "Playlist",
    "Downloads",
  ];

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.033,
              left: MediaQuery.of(context).size.width * 0.033,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: orientation == Orientation.portrait
                        ? 3
                        : 5,
                    child: CustomPageWithCards(
                      title: title,
                      customIcon: customIcon,
                      rowNumber: title.length,
                      customColor: Colors.white)
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Recently Playlist",
                              style: TextStyle(
                                  color: Colors.grey
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: RecentlyPlaylist(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        )
      );
  }
}