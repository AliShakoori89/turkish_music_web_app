import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/new_music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_music_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import '../../../bloc/new_music_bloc/event.dart';
import '../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../ui/main_page/play_music_page.dart';

class NewMusicContainer extends StatefulWidget {

  const NewMusicContainer({super.key});

  @override
  State<NewMusicContainer> createState() => NewMusicContainerState();
}

class NewMusicContainerState extends State<NewMusicContainer> {

  int _currentIndex = 0;

  @override
  void initState() {
    BlocProvider.of<NewMusicBloc>(context).add(GetNewMusicEvent());
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
          BlocBuilder<NewMusicBloc, NewMusicState>(builder: (context, state) {

          List<NewMusicDataModel> newSong = state.newMusic;

          if(state.status.isLoading){
            return const NewMusicShimmerContainer();
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

                            BlocProvider.of<IsPlayingMusicBloc>(context).add(
                                SetIsPlayingMusicEvent(
                                    musicFilePath: newSong[index].fileSource,
                                    singerName: newSong[index].name,
                                    imagePath: newSong[index].imageSource));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayMusicPage(
                                    imagePath: newSong[index].imageSource,
                                    singerName: newSong[index].name,
                                    musicFile: newSong[index].fileSource,
                                  )),
                            );
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
            return const NewMusicShimmerContainer();
          }
          return const NewMusicShimmerContainer();
          }),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.055,
          ),
        ],
      );
  }
}
