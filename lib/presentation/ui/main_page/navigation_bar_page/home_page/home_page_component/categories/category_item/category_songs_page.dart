import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/category_item_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/custom_indicator.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/song_card.dart';
import '../../../../../../../../data/model/album_model.dart';
import '../../../../../../../../data/model/category_model.dart';
import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../../bloc/category_item_bloc/bloc.dart';
import '../../../../../../../bloc/category_item_bloc/event.dart';
import '../../../../../../../helpers/widgets/back_button_if_ios_web.dart';
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
    BlocProvider.of<CategoryItemBloc>(context).add(ResetCategorySongsEvent());
    BlocProvider.of<CategoryItemBloc>(context).add(GetCategorySongsByIDEvent(categoryID: widget.categoryID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var height = double.infinity;
    var width = double.infinity;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          centerTitle: true,
          leading: buildBackButtonIfIosWeb(),
        ),
      body: BlocBuilder<CategoryItemBloc, CategoryItemState>(
          builder: (context, state) {

            List<CategoryMusicsModel>? categoryAllSongs = state.category.musics;

            if(state.status.isLoading){
              return Padding(
                  padding: EdgeInsets.only(
                      top: height / 5
                  ),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomIndicator()));
            }else if(state.status.isSuccess && categoryAllSongs != null){

              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: categoryAllSongs.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){

                        var newPath = categoryAllSongs[index].fileSource!.replaceAll(" ", "%20");

                        SongDataModel songDataModel = SongDataModel(
                          id : categoryAllSongs[index].id,
                          name: categoryAllSongs[index].name,
                          imageSource: categoryAllSongs[index].imageSource,
                          fileSource: newPath,
                          minute: categoryAllSongs[index].minute,
                          second: categoryAllSongs[index].second,
                          singerName: categoryAllSongs[index].singerName,
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
                            'singerName': songDataModel.singerName,
                            'songImage': songDataModel.imageSource,
                            'albumID': songDataModel.albumId!,
                            'pageName': "CategorySongPage",
                            'albumSongList': state.category.musics!.map((categoryMusic) => AlbumDataMusicModel.fromCategoryMusicModel(categoryMusic))
                                .toList(),
                            'songDataModel': songDataModel,
                            'categoryID': widget.categoryID
                          },
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 15
                          ),
                          child: Container(
                            width: width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15
                                  ),
                                  child: Text((index+1).toString()),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SongCard(
                                      songName: categoryAllSongs[index].name!,
                                      imgPath: categoryAllSongs[index].imageSource!,
                                      singerName: categoryAllSongs[index].singerName!),
                                )
                              ],
                            ),
                          )
                      ),
                    );
                  }
              );
            }else if(state.status.isError){
              return Center();
            }
            return Center();
          })
    );
  }
}
