import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/previous_button.dart';
import '../widgets/singer_name_trackName_image.dart';
import '../widgets/top_arrow_icon.dart';
import 'next_button.dart';

class MiniPalyingContainer extends StatelessWidget {
  const MiniPalyingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
              right: 40,
              left: 40
          ),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>
                  //       PlayMusicPage(
                  //         songID: ,
                  //         songName: ,
                  //         songFile: ,
                  //       )),
                  // );
                },
                child: const TopArrow(),),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingerNameTrackNameImage(
                            singerName: "Tarkan",
                            songName: "MoOooooOoch",
                            imagePath: "assets/images/tarkan.png",
                            align: MainAxisAlignment.start),

                      ]),
                  Row(
                    children: [
                      PreviousButton(),
                      PlayButton(),
                      NextButton()
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
