import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import 'package:turkish_music_app/presentation/ui/singer_page.dart';
import '../../../bloc/singer_bloc/bloc.dart';
import '../../../bloc/singer_bloc/event.dart';
import '../../../bloc/singer_bloc/state.dart';
import '../../../const/shimmer_container/artist_shimmer_container.dart';
import '../../../const/title.dart';

class SingerContainer extends StatelessWidget {

  const SingerContainer({super.key});


  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SingerBloc>(context).add(GetFamousSingerEvent());
    BlocProvider.of<SingerBloc>(context).add(GetAllSingerNameEvent());
    BlocProvider.of<SingerBloc>(context).add(GetAllSingerEvent());

    return BlocBuilder<SingerBloc, SingerState>(builder: (context, state) {

      List<SingerDataModel> artistList = state.famousSinger;
      List<SingerDataModel> allSinger = state.allSinger;
      List<String> allSingerName = state.allSingerName;

      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TitleText(
            title: "Singer",
            haveSeeAll: true,
            allSinger: allSinger,
            allSingerName: allSingerName,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0052,
                vertical: MediaQuery.of(context).size.width * 0.0055),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: AnimatedListView(
              duration: 100,
              scrollDirection: Axis.horizontal,
              cacheExtent: 1000,
              children: List.generate(artistList.length, (index) {
                return InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SingerPage(
                                  artistDetail: artistList[index],
                                ))
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CachedNetworkImage(
                            imageUrl: artistList[index].imageSource,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.purple.withOpacity(0.5),
                                      strokeAlign: BorderSide.strokeAlignOutside),
                                  shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(artistList[index].imageSource),
                                  fit: BoxFit.fitWidth
                              )),
                            ),
                            placeholder: (context, url) => ArtistShimmerContainer(shimmerLength: artistList.length,),
                            errorWidget: (context, url, error) => Icon(Icons.error),
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
          )
        ],
      );
    });
  }
}
