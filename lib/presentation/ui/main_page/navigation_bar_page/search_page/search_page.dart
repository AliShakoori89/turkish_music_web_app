import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/custom_indicator.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page/debouncer.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../bloc/song_bloc/bloc.dart';
import '../../../../bloc/song_bloc/event.dart';
import '../../../../bloc/song_bloc/state.dart';
import '../../../../const/generate_new_path.dart';
import '../../../../helpers/widgets/song_card.dart';
import '../../../play_song_page/play_song_page.dart';

class SearchPage extends StatefulWidget {

  static String routeName = "SearchPage";

  @override
  State<SearchPage> createState() => _searchPageState();
}

class _searchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{

  final songCharController = TextEditingController();
  final albumCharController = TextEditingController();
  Debouncer debouncer = Debouncer(milliseconds: 5000);

  @override
  void dispose() {
    debouncer.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search Page',
          style: TextStyle(
            fontSize: 20,
          ),),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20
                  ),
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white, width: 0.5), // Default border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.purple, width: 1), // On focus
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search for Items",
                      prefixIcon: const Icon(Icons.search,
                        color: Colors.white,),
                      prefixIconColor: Colors.white,
                    ),
                    onChanged: (val){
                      if (val.trim().isNotEmpty) {
                        // Only trigger events when the text field is not empty

                        debouncer.run((){
                          print(val);
                          BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent(char: val));
                          BlocProvider.of<AlbumBloc>(context).add(GetAllAlbumEvent(char: val));
                        });

                      } else {
                        // Optionally, you can clear the list or reset the state
                        // BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent(char: ""));
                        // BlocProvider.of<AlbumBloc>(context).add(GetAllAlbumEvent(char: ""));
                      }
                    },
                  )
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20
                ),
                child: Text("Song :"),
              ),
              Container(
                  height: orientation == Orientation.portrait
                      ? (MediaQuery.of(context).size.height / 2) - 200
                      : MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(
                      left: 10,
                      right: orientation == Orientation.portrait
                          ? 10
                          : 100,
                      top: 20
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple)
                  ),
                  child: BlocBuilder<SongBloc, SongState>(
                      builder: (context, state) {

                        List<SongDataModel> allSong = state.allSongList;

                        if(state.status.isLoading){
                          return CustomIndicator();
                        } else if(state.status.isSuccess){
                          return allSong.isNotEmpty
                              ? Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: AnimatedListView(
                                  scrollDirection: Axis.vertical,
                                  children: List.generate(
                                      allSong.length,
                                      (index) => GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.black87,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 0.5),
                                                        color: Colors.purple.withOpacity(0.5))
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 10,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      height: orientation == Orientation.portrait
                                                          ? MediaQuery.of(context).size.height * 0.08
                                                          : 50,
                                                      child: InkWell(
                                                        onTap: () {
                                                          var path = generateNewPath(allSong[index].fileSource);

                                                          var newPath = path.replaceAll(" ", "%20");

                                                          SongDataModel songDataModel = SongDataModel(
                                                              id: allSong[index].id,
                                                              name: allSong[index].name,
                                                              imageSource: allSong[index].imageSource,
                                                              fileSource: newPath,
                                                              minute: allSong[index].minute,
                                                              second: allSong[index].second,
                                                              singerName: allSong[index].singerName,
                                                              album: null,
                                                              albumId: allSong[index].id,
                                                              categories: null);

                                                          context.push('/' + PlaySongPage.routeName,
                                                            extra: {
                                                              'songName': songDataModel.name,
                                                              'songFile': newPath,
                                                              'songID': songDataModel.id!,
                                                              'singerName': songDataModel.singerName,
                                                              'songImage': songDataModel.imageSource!,
                                                              'albumID': songDataModel.albumId!,
                                                              'pageName': "SearchPage",
                                                              'albumSongList': <AlbumDataMusicModel>[],
                                                              'songDataModel': songDataModel,
                                                              'categoryID': 0
                                                            },
                                                          );
                                                        },
                                                        child: SongCard(
                                                          songName: allSong[index].name!,
                                                          imgPath: allSong[index].imageSource ?? "",
                                                          singerName: allSong[index].singerName ?? "",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                ),
                              )
                            : Container();
                        }else if(state.status.isError){
                          return Container();
                        }

                        return Container();

                      })
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20
                ),
                child: Text("Album :"),
              ),
              Container(
                  height: orientation == Orientation.portrait
                      ? (MediaQuery.of(context).size.height / 2) - 200
                      : MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple)
                  ),
                  margin: EdgeInsets.only(
                      left: 10,
                      right: orientation == Orientation.portrait
                          ? 10
                          : 100,
                      top: 20
                  ),
                  child: BlocBuilder<AlbumBloc, AlbumState>(
                      builder: (context, state) {

                        List<AlbumDataModel> allAlbum = state.allAlbum;

                        if(state.status.isLoading){
                          return CustomIndicator();
                        } else if(state.status.isSuccess){
                          return allAlbum.isNotEmpty
                              ? Container(
                            margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10
                            ),
                                child: AnimatedListView(
                                  scrollDirection: Axis.vertical,
                                  children: List.generate(
                                      allAlbum.length,
                                      (index) => GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.black87,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0, 0.5),
                                                        color: Colors.purple
                                                            .withOpacity(0.5))
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    flex: 10,
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      height: orientation ==
                                                              Orientation
                                                                  .portrait
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.08
                                                          : 50,
                                                      child: InkWell(
                                                        onTap: () {

                                                          var path = generateNewPath(allAlbum[index].musics![0].fileSource!);

                                                          var newPath = path.replaceAll(" ", "%20");

                                                          SongDataModel
                                                              songDataModel =
                                                              SongDataModel(
                                                            id: allAlbum[index].musics![0].id,
                                                            name: allAlbum[index].musics![0].name,
                                                            imageSource: allAlbum[index].imageSource,
                                                            fileSource: newPath,
                                                            minute: allAlbum[index].musics![0].minute,
                                                            second: allAlbum[index].musics![0].second,
                                                            singerName: allAlbum[index].singer!.name,
                                                            album: null,
                                                            albumId: allAlbum[index].id,
                                                            categories: <SongDataCategoriesModel>[
                                                              SongDataCategoriesModel(
                                                                  creationDate: '',
                                                                  id: 0,
                                                                  imageSource: '',
                                                                  musics: [],
                                                                  title: '')
                                                            ],
                                                          );

                                                          context.push('/' + PlaySongPage.routeName,
                                                            extra: {
                                                              'songName': songDataModel.name,
                                                              'songFile': newPath,
                                                              'songID': songDataModel.id!,
                                                              'singerName': songDataModel.singerName,
                                                              'songImage': allAlbum[index].imageSource,
                                                              'albumID': songDataModel.albumId!,
                                                              'pageName': "SearchPage",
                                                              'albumSongList': allAlbum[index].musics!,
                                                              'songDataModel': songDataModel,
                                                              'categoryID': 0
                                                            },
                                                          );
                                                        },
                                                        child: SongCard(
                                                          songName: state.allAlbum[index].name!,
                                                          imgPath: state.allAlbum[index].imageSource ?? "",
                                                          singerName: state.allAlbum[index].singer!.name ?? "",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                ),
                              )
                              : Container();
                        }else if(state.status.isError){
                          return Container();
                        }

                        return Container();

                      })
              ),
            ],
          ),
        ),
      )

    );
  }
}