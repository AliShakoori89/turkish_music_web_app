import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/event.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';

import '../../../bloc/music_bloc/bloc.dart';
import '../../../bloc/music_bloc/state.dart';
import '../../../const/shimmer_container/new_album_shimmer_container.dart';

class NewAlbumContainer extends StatefulWidget {
  const NewAlbumContainer({super.key});

  @override
  State<NewAlbumContainer> createState() => _NewAlbumContainerState();
}

class _NewAlbumContainerState extends State<NewAlbumContainer> {

  @override
  void initState() {
    BlocProvider.of<MusicBloc>(context).add(GetNewAlbumEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "New Album", haveSeeAll: false),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.09,
            right: MediaQuery.of(context).size.width * 0.09,
          ),
          child: BlocBuilder<MusicBloc, MusicState>(builder: (context, state) {

            List<NewAlbumModel> newAlbum = state.newAlbum;

            print(newAlbum);

            if(state.status.isLoading){
              return const NewAlbumShimmerContainer();
            }
            else if(state.status.isSuccess){
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: AnimatedGridView(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisExtent: 170,
                      crossAxisSpacing: 50,
                      children: List.generate(
                          newAlbum.length,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      color: Colors.grey[700],
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/tarkan.png"),
                                                fit: BoxFit.fill)),
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: UnderImageSingerAndSongName(
                                        singerName: "Tarkan",
                                        songName: "Araftaeim",
                                        isArtist: true),
                                  ),
                                ],
                              )
                      )
                  ),
                );
              }
            else if(state.status.isError){

            }
            return Container();
          })

        )
      ],
    );
  }
}
