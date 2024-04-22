import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/state.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../ui/main_page/play_song_page/play_song_page.dart';

class NewMusicContainer extends StatefulWidget {

  const NewMusicContainer({super.key});

  @override
  State<NewMusicContainer> createState() => NewMusicContainerState();
}

class NewMusicContainerState extends State<NewMusicContainer> {

  int _currentIndex = 0;

  @override
  void initState() {
    BlocProvider.of<NewSongBloc>(context).add(GetNewSongEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.011,
          ),
          BlocBuilder<NewSongBloc, NewSongState>(builder: (context, state) {

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
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: List.generate(newSong.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: (){

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => CurrentSelectedSongBloc()..add(
                                          SelectSong(
                                              songName: newSong[index].name,
                                              songFile: newSong[index].fileSource,
                                              songImage: newSong[index].imageSource,
                                              id: newSong[index].id,
                                              songSingerName: newSong[index].singer.name
                                              )),
                                      child: PlayMusicPage(),
                                    )));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => PlayMusicPage(
                            //         imagePath: newSong[index].imageSource,
                            //         singerName: newSong[index].name,
                            //         musicFile: newSong[index].fileSource,
                            //         musicFiles: [],
                            //       )),
                            // );
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
          }),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.055,
          ),
        ],
      );
  }
}
