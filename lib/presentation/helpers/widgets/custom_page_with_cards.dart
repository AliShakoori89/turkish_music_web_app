import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_card.dart';

import '../../ui/main_page/navigation_bar_page/song_page/download_page.dart';
import '../../ui/main_page/navigation_bar_page/song_page/playlist_page.dart';

class CustomPageWithCards extends StatelessWidget {

  final List title;
  final List customIcon;
  final int rowNumber;
  final Color customColor;
  const CustomPageWithCards({
    super.key,
    required this.title,
    required this.customIcon,
    required this.rowNumber,
    required this.customColor});

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.1,
        right: orientation == Orientation.portrait
            ? 0
            : 30
      ),
      child: ListView.builder(
        itemCount: rowNumber,
        itemBuilder: (context, index) {
          return InkWell(
            child: CustomCard(
              customColor: customColor,
              title: title[index],
              customIcon: customIcon[index],
            ),
            onTap: (){
              if(title[index] == "Playlist"){

                context.push(
                    '/'+PlaylistPage.routeName);

              }else if(title[index] == "Downloads"){

                context.push(
                    '/'+DownloadPage.routeName);
              }

            },
          );
        },
      ),
    );
  }
}
