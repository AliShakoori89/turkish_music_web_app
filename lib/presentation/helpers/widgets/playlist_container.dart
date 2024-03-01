import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';

import '../../const/title.dart';
import '../../ui/main_page/play_music_page.dart';

class FamousArtistContainer extends StatelessWidget {
  const FamousArtistContainer({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<MusicBloc>(context).add(GetFamousArtistEvent());

    return Column(
      children: [
        const TitleText(title: "Artist", haveSeeAll: true),
        BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {

          List artistList = state.famousArtist;

          print("aaaaaaaaaaaaaaaaaaaaa               "+artistList.reversed.toString());

          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0052,
                vertical: MediaQuery.of(context).size.width * 0.055
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: AnimatedListView(
              duration: 100,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  10,
                      (index) => InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlayMusicPage(
                          imagePath: "assets/images/tarkan.png",
                          singerName: "Tarkan",
                          trackName: "Araftaeim",)),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/tarkan.png"),
                                      fit: BoxFit.fill
                                  )
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Expanded(
                            flex: 1,
                            child: UnderImageSingerAndSongName(
                                singerName: "Tarkan",
                                songName: "Araftaeim",
                                isArtist: false),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          );
        }),
      ],
    );
  }
}
