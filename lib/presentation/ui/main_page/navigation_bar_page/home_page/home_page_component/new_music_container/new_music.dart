import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/model/album_model.dart';
import '../../../../../../../data/model/song_model.dart';
import '../../../../../../bloc/current_selected_song/current_selected_song_bloc.dart';
import '../../../../../../bloc/new_song_bloc/bloc.dart';
import '../../../../../../bloc/new_song_bloc/event.dart';
import '../../../../../../bloc/new_song_bloc/state.dart';
import '../../../../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../../../play_song_page/play_song_page.dart';

class NewSong extends StatefulWidget {
  const NewSong({super.key, required this.orientation});
  final Orientation orientation;

  @override
  State<NewSong> createState() => _NewSongState();
}

class _NewSongState extends State<NewSong>{

  @override
  void initState() {
    BlocProvider.of<NewSongBloc>(context).add(GetNewSongEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<NewSongBloc, NewSongState>(builder: (context, state) {

      List<AlbumDataMusicModel> newSong = state.newSong;

      return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CarouselSlider(
              options: CarouselOptions(
                height: widget.orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height / 5
                    : width < 700
                    ? MediaQuery.of(context).size.height / 2
                    : MediaQuery.of(context).size.height / 3 ,
                viewportFraction: widget.orientation == Orientation.portrait
                    ? 0.7
                    : 0.5,
                autoPlay: true,
                enlargeCenterPage: true,
                pageSnapping: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) {
                  setState(() {
                  });
                },
              ),
              items: List.generate(newSong.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: (){

                      SongDataModel songDataModel = SongDataModel(
                          id : newSong[index].id,
                          name: newSong[index].name,
                          imageSource: newSong[index].imageSource,
                          fileSource: newSong[index].fileSource!.substring(0, 4)
                              + "s"
                              + newSong[index].fileSource!.substring(4, newSong[index].fileSource!.length),
                          minute: newSong[index].minute,
                          second: newSong[index].second,
                          singerName: newSong[index].singerName,
                          album: null,
                          albumId: null,
                          categories: null
                      );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => CurrentSelectedSongBloc()..add(SelectSongEvent(
                                    songModel: songDataModel
                                )),
                                child: PlaySongPage(
                                  songName: state.newSong[index].name!,
                                  songFile:
                                  state.newSong[index].fileSource!.substring(0, 4)
                                      + "s"
                                      + state.newSong[index].fileSource!.substring(4, state.newSong[index].fileSource!.length),
                                  songID: state.newSong[index].id!,
                                  songImage: state.newSong[index].imageSource!,
                                  singerName: state.newSong[index].singerName!,
                                  albumSongList: newSong,
                                  albumID: 0,
                                  pageName: "NewSong",
                                  orientation: widget.orientation,
                                ),

                              )));
                    },
                    child: CachedNetworkImage(
                      imageUrl: newSong[index].imageSource!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: widget.orientation == Orientation.portrait
                            ? null
                            : MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.purple.withOpacity(0.5),
                                  strokeAlign: BorderSide.strokeAlignOutside),
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                  image: NetworkImage(newSong[index].imageSource!),
                                  opacity: 0.2,
                                  fit: BoxFit.fitWidth
                              )
                          ),
                        child: CachedNetworkImage(
                          imageUrl: newSong[index].imageSource!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(newSong[index].imageSource!),
                                      fit: BoxFit.contain,
                                  )
                              ),
                            )
                        )
                      ),
                      placeholder: (context, url) => NewSongShimmerContainer(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              }
              )
          )
      );
    });
  }
}
