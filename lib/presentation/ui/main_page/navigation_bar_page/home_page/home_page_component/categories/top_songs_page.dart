import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/song_card.dart';

import '../../../../../../../data/model/album_model.dart';
import '../../../../../../../data/model/song_model.dart';
import '../../../../../play_song_page/play_song_page.dart';

class TopSongPage extends StatefulWidget {

  static String routeName = "TopSongPage";
  final String imageSource;

  const TopSongPage({super.key, required this.imageSource});

  @override
  State<TopSongPage> createState() => _TopSongPageState();
}

class _TopSongPageState extends State<TopSongPage> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: height / 3.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(widget.imageSource),
                          fit: BoxFit.fill,
                          scale: 0.5)
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
        
                  builder: (context, state) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                      itemCount: state.category[0].musics.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){

                            var path = state.category[0].musics[index].fileSource.substring(0, 4)
                                + "s"
                                + state.category[0].musics[index].fileSource
                                    .substring(4, state.category[0].musics[index].fileSource.length);

                            var newPath = path.replaceAll(" ", "%20");

                            SongDataModel songDataModel = SongDataModel(
                              id : state.category[0].musics[index].id,
                              name: state.category[0].musics[index].name,
                              imageSource: state.category[0].musics[index].imageSource,
                              fileSource: newPath,
                              minute: state.category[0].musics[index].minute,
                              second: state.category[0].musics[index].second,
                              singerName: "",
                              album: null,
                              albumId: state.category[0].musics[index].albumId,
                              categories: null,
                            );

                            context.push(
                              '/'+PlaySongPage.routeName,
                              extra: {
                                'songName': songDataModel.name,
                                'songFile': songDataModel.fileSource,
                                'songID': songDataModel.id!,
                                'singerName': "",
                                'songImage': "http://194.5.195.145/TurkishMusicFiles/MusicPhotos/2024-10-02-08-33-30-Sibel-Can-Bu-Devirde-1997.jpg",
                                'albumID': songDataModel.albumId!,
                                'pageName': "RecentlyPlaylist",
                                'albumSongList': state.category[0].musics.map((categoryMusic) => AlbumDataMusicModel.fromCategoryMusicModel(categoryMusic))
                                    .toList(),
                                'songDataModel': songDataModel,
                              },
                            );
                          },
                          child: SizedBox(
                            height: height / 10,
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.category[0].musics[index].imageSource),
                                    fit: BoxFit.fill)
                                  ),
                                ),
                                SongCard(
                                    songName: state.category[0].musics[index].name,
                                    imgPath: state.category[0].musics[index].imageSource,
                                    singerName: ""),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  })
            ],
            ),
          ),
        ),
      )
    );
  }
}
