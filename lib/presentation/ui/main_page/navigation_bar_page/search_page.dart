import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_page/search_page.dart';
import 'package:searchfield/searchfield.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/song_bloc/bloc.dart';
import '../../../bloc/song_bloc/event.dart';
import '../../../bloc/song_bloc/state.dart';
import '../../../bloc/song_control_bloc/audio_control_bloc.dart';
import '../../play_song_page/play_song_page.dart';

class SearchPage extends StatefulWidget {

  static String routeName = "SearchPage";

  @override
  State<SearchPage> createState() => _searchPageState();
}

class _searchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{

  final charController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent(char: ""));
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {

      List<SongDataModel> music = state.allSongList;
      Orientation orientation = MediaQuery.of(context).orientation;

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Search Page',
            style: TextStyle(
              fontSize: 20,
            ),),
        ),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // give the tab bar a height [can change hheight to preferred height]
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.purple,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Song',
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Album',
                        ),
                      ],
                    ),
                  ),
                  // tab bar view here
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SearchField(
                              controller: charController,
                              hint: "Enter album and music name",
                              itemHeight: 70,
                              suggestions: music
                                  .map(
                                    (e) => SearchFieldListItem(
                                  e.name!,
                                  item: e,
                                  // Use child to show Custom Widgets in the suggestions
                                  // defaults to Text widget
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          var path = e.fileSource!.substring(0, 4)
                                              + "s"
                                              + e.fileSource!.substring(4, e.fileSource!.length);

                                          var newPath = path.replaceAll(" ", "%20");

                                          SongDataModel songDataModel = SongDataModel(
                                            id : e.id,
                                            name: e.name,
                                            imageSource: e.imageSource,
                                            fileSource: newPath,
                                            minute: e.minute,
                                            second: e.second,
                                            singerName: e.singerName,
                                            album: null,
                                            albumId: e.albumId,
                                            categories: null,
                                          );

                                          context.push(
                                            '/'+PlaySongPage.routeName,
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
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(e.imageSource!),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(e.name!)),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(e.singerName!,
                                                      style: TextStyle(
                                                          color: Colors.grey
                                                      ),))
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ).toList(),
                            )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10,
                              right: 10
                          ),
                          child: SearchField(
                            controller: charController,
                            hint: "Enter album and music name",
                            itemHeight: 70,
                            suggestions: music
                                .map(
                                  (e) => SearchFieldListItem(
                                e.name!,
                                item: e,
                                // Use child to show Custom Widgets in the suggestions
                                // defaults to Text widget
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: (){
                                        var path = e.fileSource!.substring(0, 4)
                                            + "s"
                                            + e.fileSource!.substring(4, e.fileSource!.length);

                                        var newPath = path.replaceAll(" ", "%20");

                                        SongDataModel songDataModel = SongDataModel(
                                          id : e.id,
                                          name: e.name,
                                          imageSource: e.imageSource,
                                          fileSource: newPath,
                                          minute: e.minute,
                                          second: e.second,
                                          singerName: e.singerName,
                                          album: null,
                                          albumId: e.albumId,
                                          categories: null,
                                        );

                                        context.push(
                                          '/'+PlaySongPage.routeName,
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
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(e.imageSource!),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(e.name!)),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(e.singerName!,
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                    ),))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ).toList(),
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      );

        });
  }
}
