import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/ui/music_page/detail_page.dart';
import 'package:turkish_music_app/presentation/ui/singer_page.dart';

import '../../data/model/singer_model.dart';

class TitleText extends StatelessWidget {

  final String title;
  final bool haveSeeAll;
  List<SingerDataModel>? allSinger;
  TitleText({super.key, required this.title, required this.haveSeeAll, this.allSinger});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                fontFamily: 'Salsa'
            )),
        haveSeeAll == true
            ? InkWell(
          onTap: (){

            if(title == "Singer"){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  AllSingerPage(allSinger: allSinger!,)));
            }else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              const DetailPage(
                songName: "Şımarık",
                singerName: "Tarkan",
                singerImage: "assets/images/tarkan.png",)));
            }
          },
          child: const Text(
              "see all >>",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey
          )),
            )
            : const Text("")
      ],
    );
  }
}
