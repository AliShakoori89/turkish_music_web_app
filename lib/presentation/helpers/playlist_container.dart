import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/presentation/helpers/under_image_singar_and_song_name.dart';

import '../const/title.dart';
import '../ui/main_page/play_music_page.dart';

class PlaylistContainer extends StatelessWidget {
  const PlaylistContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleText(title: "Playlists", haveSeeAll: true),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.0052,
              vertical: MediaQuery.of(context).size.width * 0.055),
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: AnimatedListView(
            duration: 100,
            scrollDirection: Axis.horizontal,
            children: List.generate(
                10,
                (index) => InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PlayMusicPage(
                        imagePath: "assets/images/tarkan.png",
                      singerName: "Tarkan",
                      trackName: "Araftaeim",)),
                    );
                  },
                  child: Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.030,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/tarkan.png"),
                                    fit: BoxFit.fill
                                  )
                                ),
                                width: MediaQuery.of(context).size.width * 0.22,
                              ),
                            ),
                            const SizedBox(height: 3,),
                            const Expanded(
                              flex: 1,
                              child: UnderImageSingerAndSongName(
                                  singerName: "Tarkan",
                                  songName: "Araftaeim"),
                            )
                          ],
                        ),
                      ),
                )),
          ),
        ),
      ],
    );
  }
}
