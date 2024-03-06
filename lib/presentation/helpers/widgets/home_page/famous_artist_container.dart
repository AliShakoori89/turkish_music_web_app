import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import '../../../const/shimmer_container/artist_shimmer_container.dart';
import '../../../const/title.dart';
import '../../../ui/main_page/play_music_page.dart';

class FamousArtistContainer extends StatefulWidget {
  const FamousArtistContainer({super.key});

  @override
  State<FamousArtistContainer> createState() => _FamousArtistContainerState();
}

class _FamousArtistContainerState extends State<FamousArtistContainer> {

  @override
  void initState() {
    BlocProvider.of<MusicBloc>(context).add(GetFamousArtistEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const TitleText(title: "Artist", haveSeeAll: true),
        BlocBuilder<MusicBloc, MusicState>(builder: (context, state) {

          List<SingerDataModel> artistList = state.famousArtist;

          if(state.status.isLoading){
            return ArtistShimmerContainer(shimmerLength: artistList.length);
          }
          else if(state.status.isSuccess){
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.0052,
                  vertical: MediaQuery.of(context).size.width * 0.0055),
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: AnimatedListView(
                duration: 100,
                scrollDirection: Axis.horizontal,
                children: List.generate(artistList.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayMusicPage(
                              imagePath: artistList[index].imageSource,
                              singerName: artistList[index].name,
                            )),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          artistList[index].imageSource),
                                      fit: BoxFit.fill)),
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: UnderImageSingerAndSongName(
                                singerName: artistList[index].name,
                                isArtist: false),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }
          else if(state.status.isError){
            return ArtistShimmerContainer(shimmerLength: artistList.length);
          }
          return ArtistShimmerContainer(shimmerLength: artistList.length);
        }),
      ],
    );
  }
}
