import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/song_card.dart';

import '../../../../../../../../data/model/album_model.dart';
import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../play_song_page/play_song_page.dart';

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
                      itemCount: state.category[0].musics!.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){

                            var path = state.category[0].musics![index].fileSource!.substring(0, 4)
                                + "s"
                                + state.category[0].musics![index].fileSource!
                                    .substring(4, state.category[0].musics![index].fileSource!.length);

                            var newPath = path.replaceAll(" ", "%20");

                            SongDataModel songDataModel = SongDataModel(
                              id : state.category[0].musics![index].id,
                              name: state.category[0].musics![index].name,
                              imageSource: state.category[0].musics![index].imageSource,
                              fileSource: newPath,
                              minute: state.category[0].musics![index].minute,
                              second: state.category[0].musics![index].second,
                              singerName: "",
                              album: null,
                              albumId: state.category[0].musics![index].albumId,
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
                                'albumSongList': state.category[index].musics!.map((categoryMusic) => AlbumDataMusicModel.fromCategoryMusicModel(categoryMusic))
                                    .toList(),
                                'songDataModel': songDataModel,
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 15
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text((index+1).toString())
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 15,
                                  child: Container(
                                    width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 1,
                                                offset: Offset(0, 2),
                                                color: Colors.purple.withOpacity(0.5)
                                            )
                                          ]
                                      ),
                                    child: SongCard(
                                        songName: state.category[0].musics![index].name!,
                                        imgPath: state.category[0].musics![index].imageSource!,
                                        singerName: state.category[0].musics![index].singerName!)
                                  ),
                                ),
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
