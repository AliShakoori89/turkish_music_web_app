import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/presentation/const/custom_indicator.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../bloc/recently_play_song_bloc/bloc.dart';
import '../../../../bloc/recently_play_song_bloc/event.dart';
import '../../../../bloc/recently_play_song_bloc/state.dart';
import '../../../../const/custom_divider.dart';
import '../../../../const/no_music_widget.dart';
import '../../../../helpers/widgets/singer_name_trackName_image.dart';
import '../../../../helpers/widgets/song_card.dart';
import '../../../../helpers/widgets/song_detail_list.dart';
import '../../../play_song_page/play_song_page.dart';

class RecentlyPlaylist extends StatefulWidget {

  @override
  State<RecentlyPlaylist> createState() => _RecentlyPlaylistState();
}

class _RecentlyPlaylistState extends State<RecentlyPlaylist> {

  @override
  void initState() {
    BlocProvider.of<RecentlyPlaySongBloc>(context).add(GetAllPlayedSongsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: BlocBuilder<RecentlyPlaySongBloc , RecentlyPlaySongState>(
          builder: (context, state){

            if(state.status.isLoading){
              return CustomIndicator();
            }
            else if(state.status.isSuccess){

              return state.allRecentlySongs.isNotEmpty
                  ? GestureDetector(
                child: AnimatedListView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                      state.allRecentlySongs.length,
                          (index) => GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.black87,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0.5),
                                      color: Colors.purple.withValues(alpha: 0.5),
                                  )
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 10,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: orientation == Orientation.portrait
                                        ? MediaQuery.of(context).size.height * 0.08
                                        : 50,
                                    child: SongCard(
                                      songName: state.allRecentlySongs[index].name!,
                                      imgPath: state.allRecentlySongs[index].imageSource!,
                                      singerName: state.allRecentlySongs[index].singerName ?? "",),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () => BottomDialog(
                                          songImage: state.allRecentlySongs[index].imageSource!,
                                          singerName: state.allRecentlySongs[index].name!,
                                          songName: state.allRecentlySongs[index].singerName!,
                                          orientation: orientation
                                      ).showBottomDialog(context),
                                      icon: const Icon(Icons.more_vert, size: 20,
                                      )),
                                )
                              ],
                            ),
                          ),
                          onTap: (){

                            SongDataModel songDataModel = SongDataModel(
                              id : state.allRecentlySongs[index].id,
                              name: state.allRecentlySongs[index].name,
                              imageSource: state.allRecentlySongs[index].imageSource,
                              fileSource: state.allRecentlySongs[index].fileSource,
                              minute: state.allRecentlySongs[index].minute,
                              second: state.allRecentlySongs[index].second,
                              singerName: state.allRecentlySongs[index].singerName,
                              album: null,
                              albumId: state.allRecentlySongs[index].albumId,
                              categories: null,
                            );

                            context.push(
                              '/'+PlaySongPage.routeName,
                              extra: {
                                'songName': songDataModel.name,
                                'songFile': songDataModel.fileSource,
                                'songID': songDataModel.id!,
                                'singerName': songDataModel.singerName,
                                'songImage': songDataModel.imageSource!,
                                'albumID': songDataModel.albumId!,
                                'pageName': "RecentlyPlaylist",
                                'albumSongList': state.allRecentlySongs,
                                'songDataModel': songDataModel,
                                'categoryID': 0
                              },
                            );
                          })),
                ),
              )
                  : NoMusicWidget();
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
  final Orientation orientation;

  BottomDialog({ required this.songImage, required this.songName, required this.singerName, required this.orientation});

  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.6),
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