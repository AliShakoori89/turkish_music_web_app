import 'package:flutter/material.dart';

import '../../../../helpers/widgets/custom_page_with_cards.dart';

class MusicPage extends StatelessWidget {

  static String routeName = "/musicPage";

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
    var width = double.infinity;

    return Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.033,
              left: MediaQuery.of(context).size.width * 0.033,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: orientation == Orientation.portrait
                        ? width < 400 ? 3 : 4
                        : 5,
                    child: CustomPageWithCards(
                        title: title,
                        customIcon: customIcon,
                        rowNumber: title.length,
                        customColor: Colors.white)),
              ],
            )
          )
        )
      );
  }
}