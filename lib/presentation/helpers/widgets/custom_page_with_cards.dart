import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/custom_divider.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_card.dart';
import 'package:turkish_music_app/presentation/ui/music_page/playlist_page.dart';

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
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlaylistPage())
                );
              }else if(title[index] == "Downloads"){

              }

            },
          );
        },
      ),
    );
  }
}
