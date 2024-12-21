import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/generate_new_path.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import '../../../../../../data/model/album_model.dart';
import '../../../../../../data/model/song_model.dart';
import '../../../../../bloc/album_bloc/event.dart';
import '../../../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../../play_song_page/play_song_page.dart';

class NewAlbumContainer extends StatefulWidget {

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

    var height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 20),
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
              height: orientation == Orientation.portrait
                  ? height < 670
                  ? MediaQuery.of(context).size.height * 0.63
                  : MediaQuery.of(context).size.height * 0.51
                  : MediaQuery.of(context).size.height / 2,
              child: orientation == Orientation.portrait
                  ? AnimatedGridView(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  crossAxisSpacing: 50,
                  cacheExtent: 1000,
                  children: List.generate(
                      newAlbum.length, (index) {
                    return GestureDetector(
                      onTap: (){

                        var path = state.newAlbum[index].musics![0].fileSource!.substring(0, 4)
                            + "s"
                            + state.newAlbum[index].musics![0].fileSource!.substring(4, state.newAlbum[index].musics![0].fileSource!.length);

                        var newPath = path.replaceAll(" ", "%20");

                        SongDataModel songDataModel = SongDataModel(
                          id : state.newAlbum[index].musics![0].id,
                          name: state.newAlbum[index].musics![0].name,
                          imageSource: state.newAlbum[index].musics![0].imageSource,
                          fileSource: newPath,
                          minute: state.newAlbum[index].musics![0].minute,
                          second: state.newAlbum[index].musics![0].second,
                          singerName: state.newAlbum[index].singer!.name,
                          album: null,
                          albumId: state.newAlbum[index].musics![0].id,
                          categories: null,
                        );

                        context.push(
                          '/'+PlaySongPage.routeName,
                          extra: {
                            'songName': songDataModel.name,
                            'songFile': newPath,
                            'songID': songDataModel.id!,
                            'singerName': songDataModel.singerName,
                            'songImage': songDataModel.name,
                            'albumID': songDataModel.albumId!,
                            'pageName': "NewAlbumContainer",
                            'albumSongList': state.newAlbum[index].musics!.map((newAlbum) => AlbumDataMusicModel.fromNewAlbumDataModel(newAlbum))
                            .toList(),
                            // state.singerAllAlbum.map((newAlbumMusics) => AlbumDataMusicModel.fromCategoryMusicModel(newAlbumMusics))
                            //     .toList(),
                            'songDataModel': songDataModel,
                            'categoryID': 0,
                          },
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: CachedNetworkImage(
                                imageUrl: newAlbum[index].imageSource!,
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
                                          image: NetworkImage(newAlbum[index].imageSource!),
                                          fit: BoxFit.fill)),
                                  width: double.infinity,
                                ),
                                placeholder: (context, url) => NewSongShimmerContainer(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              )),
                          Expanded(
                            flex: 2,
                            child: UnderImageSingerAndSongName(
                                singerName: newAlbum[index].singer?.name,
                                albumName: newAlbum[index].name,
                                isArtist: true),
                          ),
                        ],
                      ),
                    );
                      }
                  ))
                  : AnimatedGridView(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisExtent: 220,
                        crossAxisSpacing: 50,
                        cacheExtent: 1000,
                        children: List.generate(newAlbum.length, (index) {
                          return GestureDetector(
                            onTap: () {

                              var path = generateNewPath(state.newAlbum[index].musics![0].fileSource!);

                              var newPath = path.replaceAll(" ", "%20");

                              SongDataModel songDataModel = SongDataModel(
                                id : state.newAlbum[index].musics![0].id,
                                name: state.newAlbum[index].musics![0].name,
                                imageSource: state.newAlbum[index].musics![0].imageSource,
                                fileSource: newPath,
                                minute: state.newAlbum[index].musics![0].minute,
                                second: state.newAlbum[index].musics![0].second,
                                singerName: state.newAlbum[index].singer!.name,
                                album: null,
                                albumId: state.newAlbum[index].musics![0].id,
                                categories: null,
                              );

                              context.push(
                                '/'+PlaySongPage.routeName,
                                extra: {
                                  'songName': songDataModel.name,
                                  'songFile': newPath,
                                  'songID': songDataModel.id!,
                                  'singerName': songDataModel.singerName,
                                  'songImage': songDataModel.name,
                                  'albumID': songDataModel.albumId!,
                                  'pageName': "NewAlbumContainer",
                                  'albumSongList': state.newAlbum[index].musics!.map((newAlbum) => AlbumDataMusicModel.fromNewAlbumDataModel(newAlbum))
                                      .toList(),
                                  'songDataModel': songDataModel,
                                  'categoryID': 0,
                                },
                              );

                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: CachedNetworkImage(
                                      imageUrl: newAlbum[index].imageSource!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.purple
                                                    .withOpacity(0.5),
                                                blurRadius: 10.0,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    newAlbum[index]
                                                        .imageSource!),
                                                fit: BoxFit.fill)),
                                        width: double.infinity,
                                      ),
                                      placeholder: (context, url) =>
                                          NewSongShimmerContainer(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: UnderImageSingerAndSongName(
                                      singerName: newAlbum[index].singer?.name,
                                      albumName: newAlbum[index].name,
                                      isArtist: true),
                                ),
                              ],
                            ),
                          );
                        })),
            );
          })
        ),
      ],
    );
  }
}
