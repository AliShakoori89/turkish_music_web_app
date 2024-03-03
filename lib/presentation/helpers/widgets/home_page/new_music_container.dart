import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import '../../../bloc/music_bloc/bloc.dart';
import '../../../bloc/music_bloc/event.dart';
import '../../../bloc/music_bloc/state.dart';

class NewMusicContainer extends StatefulWidget {
  const NewMusicContainer({super.key});

  @override
  State<NewMusicContainer> createState() => _NewMusicContainerState();
}

class _NewMusicContainerState extends State<NewMusicContainer> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<MusicBloc>(context).add(GetNewMusicEvent());

    return BlocBuilder<MusicBloc, MusicState>(builder: (context, state) {

      List<NewMusicDataModel> newSong = state.newMusic;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(title: "New Song", haveSeeAll: true),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.011,
          ),
          Padding(
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                          image: NetworkImage(newSong[index].imageSource),
                            opacity: 0.3,
                            fit: BoxFit.fitWidth
                        )
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                                image: NetworkImage(newSong[index].imageSource),
                                fit: BoxFit.contain
                            )
                        ),
                      ),
                    ),
                  );
                }
                )
              )
          ),

          SizedBox(
            height: MediaQuery.of(context).size.width * 0.055,
          ),
        ],
      );
    });
  }
}
