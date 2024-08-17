import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/mini_palying_container.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_page_with_cards.dart';
import 'package:turkish_music_app/presentation/ui/profile_page.dart';

class MusicPage extends StatelessWidget {

  MusicPage({super.key});

  List customIcon = [
    Icons.playlist_play_outlined,
    Icons.download,
  ];
  List title = [
    "Playlist",
    "Downloads",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: BlocBuilder<MiniPlayingContainerBloc, MiniPlayingContainerState>(builder: (context, state) {

      bool visibility = state.visibility;

      return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.033,
                  left: MediaQuery.of(context).size.width * 0.033,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomPageWithCards(
                        title: title,
                        customIcon: customIcon,
                        rowNumber: title.length,
                        customColor: Colors.white,)
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Recently Playlist",
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                              )
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 8,
                            child: DetailPage(
                              visibility: visibility,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MiniPlayingContainer(
                visibility: visibility,
              )
            ],
          );})
        )
      );
  }
}