import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/home_page/new_music_container/new_music.dart';
import '../../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../../ui/main_page/play_song_page/play_song_page.dart';

class NewMusicContainer extends StatefulWidget {

  @override
  State<NewMusicContainer> createState() => NewMusicContainerState();
}

class NewMusicContainerState extends State<NewMusicContainer>{


  // @override
  // void initState() {
  //   BlocProvider.of<NewSongBloc>(context).add(GetNewSongEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.011,
          ),
          NewMusic(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.055,
          ),
        ],
      );
  }
}
