import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import 'package:turkish_music_app/presentation/ui/main_page/singer_page.dart';
import '../../../bloc/singer_bloc/bloc.dart';
import '../../../bloc/singer_bloc/event.dart';
import '../../../bloc/singer_bloc/state.dart';
import '../../../const/shimmer_container/artist_shimmer_container.dart';

class FamousArtistContainer extends StatefulWidget {

  final bool isPlaying;
  late PlaybackState playbackState;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;

  FamousArtistContainer({super.key, required this.isPlaying, required this.playbackState,
    required this.player, required this.audioPlayer});

  @override
  State<FamousArtistContainer> createState() => _FamousArtistContainerState(isPlaying, playbackState, player, audioPlayer);
}

class _FamousArtistContainerState extends State<FamousArtistContainer> {

  final bool isPlaying;
  late PlaybackState playbackState;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;

  _FamousArtistContainerState(this.isPlaying, this.playbackState, this.player, this.audioPlayer);

  @override
  void initState() {
    BlocProvider.of<SingerBloc>(context).add(GetFamousSingerEvent());
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
        BlocBuilder<SingerBloc, SingerState>(builder: (context, state) {

          List<SingerDataModel> artistList = state.famousSinger;

          if(state.status.isLoading){
            return ArtistShimmerContainer(shimmerLength: artistList.length);
          }
          if(state.status.isSuccess){
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
                              builder: (context) => SingerPage(
                                artistDetail: artistList[index],
                                isPlaying: isPlaying,
                                playbackState: playbackState,
                                player: player,
                                audioPlayer: audioPlayer,
                              ))
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.withOpacity(0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
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
          if(state.status.isError){
            return ArtistShimmerContainer(shimmerLength: artistList.length);
          }
          return ArtistShimmerContainer(shimmerLength: artistList.length);
        }),
      ],
    );
  }
}
