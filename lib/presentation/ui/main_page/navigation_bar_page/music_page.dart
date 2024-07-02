import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_page_with_cards.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/singer_name_trackName_image.dart';
import 'package:turkish_music_app/presentation/ui/profile_page.dart';
import '../../../helpers/play_song_page_component/next_button.dart';
import '../../../helpers/play_song_page_component/play_button.dart';
import '../../../helpers/play_song_page_component/previous_button.dart';
import '../../../helpers/widgets/top_arrow_icon.dart';

class MusicPage extends StatelessWidget {

  MusicPage({super.key});

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
                  flex: 3,
                  child: CustomPageWithCards(
                    title: title,
                    customIcon: customIcon,
                    rowNumber: title.length,
                    customColor: Colors.white,)
                ),
                const Expanded(
                  flex: 7,
                  child: Column(
                    children: [
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
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 8,
                        child: DetailPage(
                          songName: 'Okadar',
                          singerName: "Tarkan",
                          singerImage: "assets/images/tarkan.png",
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) =>
                            //       PlayMusicPage(
                            //         imagePath: state.singerImage,
                            //         singerName: state.singerName,
                            //         musicFile: state.musicFile,
                            //         musicFiles: [],
                            //       )),
                            // );
                          },
                          child: const TopArrow(),),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.10 + 15,
                            right: MediaQuery.of(context).size.width * 0.10 + 15,
                            // top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: const Row(
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
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        )
      );
  }
}

// class CircleButton extends StatelessWidget {
//   const CircleButton({
//     required this.onPressed,
//     required this.child,
//     this.size = 35,
//     this.color = Colors.blue,
//     super.key,
//   });
//
//   final void Function()? onPressed;
//   final Widget child;
//   final double size;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size,
//       width: size,
//       child: ClipOval(
//         child: Material(
//           color: color,
//           child: InkWell(
//             canRequestFocus: false,
//             onTap: onPressed,
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }