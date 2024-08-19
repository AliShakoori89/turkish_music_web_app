import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import '../../../bloc/album_bloc/event.dart';
import '../../../const/shimmer_container/artist_shimmer_container.dart';
import '../../../const/shimmer_container/new_album_shimmer_container.dart';
import '../../../const/shimmer_container/new_music_shimmer_container.dart';

class NewAlbumContainer extends StatefulWidget {
  const NewAlbumContainer({super.key});

  @override
  State<NewAlbumContainer> createState() => _NewAlbumContainerState();
}

class _NewAlbumContainerState extends State<NewAlbumContainer> {

  @override
  void initState() {
    BlocProvider.of<AlbumBloc>(context).add(GetNewAlbumEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(title: "New Album", haveSeeAll: false),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.09,
            right: MediaQuery.of(context).size.width * 0.09,
          ),
          child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

            var newAlbum = state.newAlbum;

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: AnimatedGridView(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  crossAxisSpacing: 50,
                  cacheExtent: 1000,
                  children: List.generate(
                      newAlbum.data!.length,
                          (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 5,
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  onTap: () {
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: newAlbum.data![index].imageSource!,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                              Colors.purple.withOpacity(0.5),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(newAlbum
                                                  .data![index].imageSource!),
                                              fit: BoxFit.fill)),
                                      width: double.infinity,
                                    ),
                                    placeholder: (context, url) => NewSongShimmerContainer(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),

                                )),
                            Expanded(
                              flex: 2,
                              child: UnderImageSingerAndSongName(
                                  singerName:
                                  newAlbum.data![index].singer?.name,
                                  albumName: newAlbum.data![index].name,
                                  isArtist: true),
                            ),
                          ],
                        );
                      }
                  )
              ),
            );
          })
        ),
      ],
    );
  }
}
