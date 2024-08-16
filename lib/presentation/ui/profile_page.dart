import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import '../../data/model/song_model.dart';
import '../bloc/recently_play_song_bloc/bloc.dart';
import '../bloc/recently_play_song_bloc/event.dart';
import '../bloc/recently_play_song_bloc/state.dart';
import '../const/custom_divider.dart';
import '../const/no_music_widget.dart';
import '../helpers/widgets/singer_name_trackName_image.dart';
import '../helpers/widgets/song_detail_list.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key,
    required this.visibility});

  final bool visibility;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    BlocProvider.of<RecentlyPlaySongBloc>(context).add(GetAllPlayedSongsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: widget.visibility == true ? 90 : 0
      ),
      child: BlocBuilder<RecentlyPlaySongBloc , RecentlyPlaySongState>(
        builder: (context, state){


           if(state.status.isLoading){
             return CircularProgressIndicator();
           }else if(state.status.isSuccess){

             return AnimatedListView(
               duration: 100,
               scrollDirection: Axis.vertical,
               children: List.generate(
                   state.allRecentlySongs.length,
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
                                         image: NetworkImage(state.allRecentlySongs[index].imageSource!),
                                         fit: BoxFit.fill)
                                 ),
                               ),
                               SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(state.allRecentlySongs[index].name!),
                                   // Text(state.allRecentlySongs[index].singerName!)
                                 ],
                               )
                             ],
                           ),
                         ),
                       ),
                       Flexible(
                         child: IconButton(
                             onPressed: () => BottomDialog(
                               songImage: state.allRecentlySongs[index].imageSource!,
                               singerName: state.allRecentlySongs[index].name!,
                               songName: state.allRecentlySongs[index].singerName!,
                             ).showBottomDialog(context),
                             icon: const Icon(Icons.more_vert,
                               size: 20,)),
                       )
                     ],
                   )),
             );
           }else if(state.status.isError){
             return NoMusicWidget();
           }
           return NoMusicWidget();
        },
      )

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