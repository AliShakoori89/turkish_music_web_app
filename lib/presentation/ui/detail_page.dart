import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import '../const/custom_divider.dart';
import '../helpers/singer_name_trackName_image.dart';
import '../helpers/song_detail_list.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key,
    required this.songName,
    required this.singerName,
    required this.singerImage});

  final String songName;
  final String singerName;
  final String singerImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: AnimatedListView(
          duration: 100,
          scrollDirection: Axis.vertical,
          children: List.generate(
              10,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                height: MediaQuery.of(context).size.height * 0.065,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(singerImage),
                                  fit: BoxFit.fill)
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(songName),
                                  Text(singerName)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                            onPressed: () => BottomDialog(
                              songImage: "assets/images/tarkan.png",
                              singerName: singerName,
                                songName: songName,
                                ).showBottomDialog(context),
                            icon: const Icon(Icons.more_vert,
                            size: 20,)),
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}

class BottomDialog {

  final String songImage;
  final String songName;
  final String singerName;



  BottomDialog({ required this.songImage, required this.songName, required this.singerName,});

  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.35,
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingerNameTrackNameImage(
                    songName: songName,
                    singerName: singerName,
                    imagePath: "assets/images/tarkan.png",
                    align: MainAxisAlignment.center,
                  ),
                  const SizedBox(height: 20,),
                  const SongDetailList(
                    customIcon: Icon(Icons.playlist_add),
                    title: "Add to playlist",
                  ),
                  const CustomDivider(
                    dividerColor: Colors.grey,
                  ),
                  const SongDetailList(
                    customIcon: Icon(Icons.share),
                    title: "Share",
                  ),
                  const CustomDivider(
                    dividerColor: Colors.grey,
                  ),
                  const SongDetailList(
                    customIcon: Icon(Icons.mic),
                    title: "Go to Artist",
                  ),
                  const CustomDivider(
                    dividerColor: Colors.grey,
                  ),
                  const SongDetailList(
                    customIcon: Icon(Icons.download),
                    title: "Download",
                  ),
                ],
              ),
            ),
            )
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}