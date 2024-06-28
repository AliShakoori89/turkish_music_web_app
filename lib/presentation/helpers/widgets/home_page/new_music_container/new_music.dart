import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/new-song_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../../bloc/new_song_bloc/bloc.dart';
import '../../../../bloc/new_song_bloc/event.dart';
import '../../../../bloc/new_song_bloc/state.dart';
import '../../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../../ui/main_page/play_song_page/play_song_page.dart';

class NewMusic extends StatefulWidget {
  const NewMusic({super.key});

  @override
  State<NewMusic> createState() => _NewMusicState();
}

class _NewMusicState extends State<NewMusic> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    BlocProvider.of<NewSongBloc>(context).add(GetNewSongEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSongBloc, NewSongState>(builder: (context, state) {

      List<NewSongDataModel> newSong = state.newSong;

      if(state.status.isLoading){
        return const NewSongShimmerContainer();
      }
      else if(state.status.isSuccess){
        return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 5,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 10),
                  autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 2.0,
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
                            fileSource: newSong[index].fileSource.substring(0, 4)
                                + "s"
                                + newSong[index].fileSource.substring(4, newSong[index].fileSource.length),
                            minute: newSong[index].minute,
                            second: newSong[index].second,
                            album: null,
                            albumId: null,
                            categories: null
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                                      songModel: songDataModel
                                  )),
                                  child: PlayMusicPage(
                                    songName: state.newSong[index].name,
                                    songFile: state.newSong[index].fileSource,
                                    songID: state.newSong[index].id,
                                    newSongList: newSong,
                                  ),

                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Colors.purple.withOpacity(0.5),
                                strokeAlign: BorderSide.strokeAlignOutside),
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                                image: NetworkImage(newSong[index].imageSource),
                                opacity: 0.3,
                                fit: BoxFit.fitWidth
                            )
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(newSong[index].imageSource),
                                  fit: BoxFit.contain
                              )
                          ),
                        ),
                      ),
                    ),
                  );
                }
                )
            )
        );
      }
      else if(state.status.isError){
        return const NewSongShimmerContainer();
      }
      return const NewSongShimmerContainer();
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
