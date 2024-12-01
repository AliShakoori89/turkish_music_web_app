import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/custom_indicator.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/song_card.dart';

import '../../../../../../../../data/model/album_model.dart';
import '../../../../../../../../data/model/category_model.dart';
import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../play_song_page/play_song_page.dart';

class CategorySongPage extends StatefulWidget {

  static String routeName = "CategorySongPage";

  final String imageSource;
  final String categoryName;
  final int categoryID;

  const CategorySongPage({super.key,
    required this.imageSource,
    required this.categoryName,
    required this.categoryID});

  @override
  State<CategorySongPage> createState() => _CategorySongPageState();
}

class _CategorySongPageState extends State<CategorySongPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CategoryBloc>(context).add(ResetCategorySongsByIDEvent());
      BlocProvider.of<CategoryBloc>(context).add(GetCategorySongsByIDEvent(categoryID: widget.categoryID));
    });
    super.initState();
  }

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

                    print("###########################################################################");


                    List<CategoryMusicsModel> categoryAllSongs = state.category.musics!;

                    if(state.status.isLoading){
                      return CustomIndicator();
                    }else if(state.status.isSuccess){
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: categoryAllSongs.length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){

                                var path = categoryAllSongs[index].fileSource!.substring(0, 4)
                                    + "s"
                                    + categoryAllSongs[index].fileSource!
                                        .substring(4, categoryAllSongs[index].fileSource!.length);

                                var newPath = path.replaceAll(" ", "%20");

                                SongDataModel songDataModel = SongDataModel(
                                  id : categoryAllSongs[index].id,
                                  name: categoryAllSongs[index].name,
                                  imageSource: categoryAllSongs[index].imageSource,
                                  fileSource: newPath,
                                  minute: categoryAllSongs[index].minute,
                                  second: categoryAllSongs[index].second,
                                  singerName: "",
                                  album: null,
                                  albumId: categoryAllSongs[index].albumId,
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
                                    'albumSongList': state.category.musics!.map((categoryMusic) => AlbumDataMusicModel.fromCategoryMusicModel(categoryMusic))
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
                                              songName: categoryAllSongs[index].name!,
                                              imgPath: categoryAllSongs[index].imageSource!,
                                              singerName: categoryAllSongs[index].singerName!)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }else if(state.status.isError){
                      return Center(child: Text("error"));
                    }
                    return Center();
                  })
              ],
            ),
          ),
        ),
      )
    );
  }
}
