import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/new_song_container/new_song_page/new_song_page.dart';
import '../../data/model/singer_model.dart';
import '../ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/all_singer_page.dart';

class TitleText extends StatelessWidget {

  final String title;
  final bool haveSeeAll;
  List<SingerDataModel>? allSinger;
  List<SongDataModel>? newSongs;
  List<String>? allSingerName;

  TitleText({super.key, required this.title, required this.haveSeeAll,
    this.allSinger, this.allSingerName, this.newSongs});

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

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

              context.push("/"+AllSingerPage.routeName, extra: {
                'allSinger': allSinger,
                'allSingerName': allSingerName,
              },);

            }else if(title == "New Songs"){

              context.push("/"+NewSongPage.routeName);
            }
          },
          child: Padding(
            padding: orientation != Orientation.portrait
                ? const EdgeInsets.only(right: 50)
                : EdgeInsets.all(0),
            child: const Text(
                "see all >>",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey
            )),
          ),
            )
            : const Text("")
      ],
    );
  }
}
