import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_page/search_page.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/song_bloc/bloc.dart';
import '../../../bloc/song_bloc/event.dart';
import '../../../bloc/song_bloc/state.dart';
import '../../play_song_page/play_song_page.dart';

class searchPage extends StatefulWidget {

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {

  @override
  void initState() {
    BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {

      List<SongDataModel> music = state.allSongList;
      Orientation orientation = MediaQuery.of(context).orientation;


      return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Center(
                        child: Text('Search Page',
                          style: TextStyle(
                            fontSize: 20,
                          ),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: orientation == Orientation.portrait
                                  ?  0
                                  : 50
                          ),
                          child: IconButton(
                              onPressed: () => showSearch(
                                context: context,
                                delegate: SearchPage(
                                  onQueryUpdate: print,
                                  items: music,
                                  searchLabel: 'Search Track Name ',
                                  suggestion: const Center(
                                    child: Text('Filter track by track name'),
                                  ),
                                  failure: const Center(
                                    child: Text('Not found :('),
                                  ),
                                  filter: (musicItem) => [
                                    musicItem.name],
                                  // sort: (a, b) => a.compareTo(b),
                                  builder: (musicItem) => GestureDetector(
                                    onTap: (){

                                      SongDataModel songDataModel = SongDataModel(
                                        id : musicItem.id,
                                        name: musicItem.name,
                                        imageSource: musicItem.imageSource,
                                        fileSource: musicItem.fileSource!.substring(0, 4)
                                            + musicItem.fileSource!.substring(4, musicItem.fileSource!.length),
                                        singerName: musicItem.singerName,
                                        minute: musicItem.minute,
                                        second: musicItem.second,
                                        albumId: musicItem.albumId,
                                      );

                                      context.push(
                                        '/'+PlaySongPage.routeName,
                                        extra: {
                                          'songName': songDataModel.name,
                                          'songFile': songDataModel.fileSource,
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
                                    child: ListTile(
                                      title: Text(musicItem.name!),
                                    ),
                                  ),
                                ),
                              ),
                              icon: Icon(Icons.search)),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: DelayedWidget(// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GestureDetector(
                              onTap: (){

                              },
                              child: music.isNotEmpty
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(music[index].name!),
                                  Text(music[index].singerName!,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5)
                                    ),),
                                ],
                              )
                                  :Container(),
                            ),
                          );
                        },
                      )),
                )],
            )
        ),
      );

        });
  }
}
