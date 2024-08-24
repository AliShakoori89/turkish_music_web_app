import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';
import '../../../../data/model/album_model.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/state.dart';
import '../../../bloc/song_bloc/bloc.dart';
import '../../../bloc/song_bloc/event.dart';
import '../../../bloc/song_bloc/state.dart';
import '../../../const/searching_error.dart';
import '../../../helpers/play_song_page_component/mini_palying_container.dart';
import '../../play_song_page.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(builder: (context, state) {

      List<SongDataModel> music = state.allSongList;

      if(state.status.isLoading){
        return Center(
          child: Image.asset(
            "assets/custom_icons/loading_play.gif",
            height: 125.0,
            width: 125.0,
          ),
        );
      }
      else if(state.status.isSuccess){
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
                          child: IconButton(
                              onPressed: () => showSearch(
                                context: context,
                                delegate: SearchPage(
                                  onQueryUpdate: print,
                                  items: music,
                                  searchLabel: 'Search Singer or Track name ',
                                  suggestion: const Center(
                                    child: Text('Filter track by track name or singer'),
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
                                            + "s"
                                            + musicItem.fileSource!.substring(4, musicItem.fileSource!.length),
                                        singerName: musicItem.singerName,
                                        minute: musicItem.minute,
                                        second: musicItem.second,
                                        albumId: musicItem.albumId,
                                      );

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                                                    songModel: songDataModel
                                                )),
                                                child: PlaySongPage(
                                                  songName: musicItem.name!,
                                                  songFile: musicItem.fileSource!,
                                                  songID: musicItem.id!,
                                                  singerName: musicItem.singerName!,
                                                  songImage: musicItem.album!.imageSource!,
                                                  pageName: "searchPage",
                                                  albumID: 0,
                                                  albumSongList: [],
                                                ),

                                              )));
                                    },
                                    child: ListTile(
                                      title: Text(musicItem.name!),
                                    ),
                                  ),
                                ),
                              ),
                              icon: Icon(Icons.search)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: DelayedWidget(
                        delayDuration: Duration(milliseconds: 1500),// Not required
                        animationDuration: Duration(seconds: 1),// Not required
                        animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: GestureDetector(
                                onTap: (){

                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(music[index].name!),
                                    Text(music[index].singerName!,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.5)
                                      ),),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  )],
              )
          ),
        );
      }
      else if(state.status.isError){
        return SearchingError();
      }
      return SearchingError();
    });
  }
}

