import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/event.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/mini_palying_container.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/state.dart';
import '../../../helpers/widgets/home_page/new_music_container/new_music_container.dart';
import '../../../helpers/widgets/header.dart';
import '../../../helpers/widgets/home_page/category_item.dart';
import '../../../helpers/widgets/home_page/new_album_contaner.dart';
import '../../../helpers/widgets/home_page/singer_container.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    print("HomePage            HomePage             HomePage                  HomePage");
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(ReadSongIDForMiniPlayingSongContainerEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocBuilder<MiniPlayingContainerBloc,
              MiniPlayingContainerState>(builder: (context, state) {



            bool visibility = state.visibility;
            int songID = state.songID;
            int albumID = state.albumID;

            print("HomePage    songID    "+songID.toString());

            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10,
                    bottom: visibility == true ? 90 : 0
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppHeader(),
                        NewMusicContainer(),
                        SingerContainer(),
                        NewAlbumContainer(),
                        CategoryItemContainer()
                      ],
                    ),
                  ),
                ),
                MiniPlayingContainer(
                  visibility: visibility,
                  songID: songID,
                  albumID: albumID,
                  ),
              ],
            );
          })
      ),
    );
  }
}
