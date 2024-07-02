import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_page/search_page.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/bloc/song_bloc.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
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
    BlocProvider.of<SongBloc>(context).add(FetchAllSongs());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(builder: (context, state) {

      List<SongDataModel> music = BlocProvider.of<SongBloc>(context).allSongs;

      return Scaffold(
      body: SafeArea(
        child:  Column(
        children: [
          const SizedBox(height: 20),
          const Expanded(
            flex: 1,
            child: Text('Search Page',
              style: TextStyle(
                fontSize: 14,
              ),),
          ),
          Expanded(
            flex: 10,
            child: DelayedWidget(
                delayDuration: Duration(milliseconds: 1000),// Not required
                animationDuration: Duration(seconds: 1),// Not required
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(music[index].name!),
                    );
                  },
                )),
          )
        ],
      )
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search Singer or Track name',
        backgroundColor: Colors.grey.withOpacity(0.2),
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
                    minute: musicItem.minute,
                    second: musicItem.second,
                    album: musicItem.album,
                    albumId: musicItem.albumId,
                    categories: musicItem.categories
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                              songModel: songDataModel
                          )),
                          child: PlayMusicPage(
                            songName: musicItem.name!,
                            songFile: musicItem.fileSource!,
                            songID: musicItem.id!,
                          ),

                        )));
              },
              child: ListTile(
                title: Text(musicItem.name!),
              ),
            ),
          ),
        ),
        child: const Icon(Icons.search),
      ),
    );
    //   BlocBuilder<SearchWordBloc, SearchWordState>(builder: (context, state) {
    //   return
    });
  }
}

