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
import '../../../../../helpers/widgets/hoverable_item.dart';
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

    Orientation orientation = MediaQuery.of(context).orientation;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TitleText(title: "New Album", haveSeeAll: false),
        Padding(
          padding: EdgeInsets.only(
            top: 30,
          ),
          child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

            var newAlbum = state.newAlbum;
            var width = MediaQuery.of(context).size.width;

            print(MediaQuery.of(context).size.width);

            return SizedBox(
              height: width > 501 ? 150 : 350,
              width: 800,
              child: orientation == Orientation.portrait
                  ? Center(
                    child: Container(
                        height: width > 501
                            ? MediaQuery.of(context).size.height * 0.6
                            : 300 ,
                        child: AnimatedGridView(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: width > 500 ? 6 : 3,
                        mainAxisExtent: width > 500 ? 250 : 150,
                        crossAxisSpacing: 10,
                        cacheExtent: 1000,
                        children: List.generate(
                            newAlbum.length, (index) {
                          return GestureDetector(
                            onTap: (){

                              var newPath = state.newAlbum[index].musics![0].fileSource!.replaceAll(" ", "%20");

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
                                  'songImage': songDataModel.imageSource,
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
                            child: HoverableItem(
                              imageUrl: newAlbum[index].imageSource!,
                              name: newAlbum[index].name!,
                              boxShape: BoxShape.rectangle,
                              size: 120,
                            ),
                          );}
                        )),
                    ),
                  )
                  : Center(
                    child: Container(
                        child: AnimatedGridView(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: width > 500 ? 6 : 3,
                            mainAxisExtent: width > 500 ? 250 : 150,
                            crossAxisSpacing: 10,
                            cacheExtent: 1000,
                            children: List.generate(newAlbum.length, (index) {
                              return GestureDetector(
                                onTap: () {

                                  var newPath = state.newAlbum[index].musics![0].fileSource!.replaceAll(" ", "%20");

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
                                      'songImage': songDataModel.imageSource,
                                      'albumID': songDataModel.albumId!,
                                      'pageName': "NewAlbumContainer",
                                      'albumSongList': state.newAlbum[index].musics!.map((newAlbum) => AlbumDataMusicModel.fromNewAlbumDataModel(newAlbum))
                                          .toList(),
                                      'songDataModel': songDataModel,
                                      'categoryID': 0,
                                    },
                                  );

                                },
                                child: HoverableItem(
                                  imageUrl: newAlbum[index].imageSource!,
                                  name: newAlbum[index].name!,
                                  boxShape: BoxShape.rectangle,
                                  size: 180,
                                ),
                              );
                            })),
                    ),
                  ),
            );
          })
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
