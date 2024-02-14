import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import 'package:turkish_music_app/presentation/helpers/under_image_singar_and_song_name.dart';

class NewSong extends StatelessWidget {
  const NewSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "New Song", haveSeeAll: false),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.09,
            right: MediaQuery.of(context).size.width * 0.09,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            child: AnimatedGridView(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisExtent: 170,
                crossAxisSpacing: 50,
                children: List.generate(
                    4,
                        (index) =>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                color: Colors.grey[700],
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/tarkan.png"),
                                          fit: BoxFit.fill)),
                                  width: double.infinity,
                                ),
                              ),
                                ),
                                const Expanded(
                                  flex: 2,
                                  child: UnderImageSingerAndSongName(
                                      singerName: "Tarkan",
                                      songName: "Araftaeim",
                                  isArtist: true),
                                ),
                              ],
                            ))),
          ),
        )
      ],
    );
  }
}
