import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/container_all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/circular_seekbar.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/download_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/normalize_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/play_list_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/repeat_button.dart';
import '../../../../data/model/album_model.dart';
import '../../../../data/model/new-song_model.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/play_box_bloc/bloc.dart';
import '../../../bloc/play_box_bloc/event.dart';
import '../../../bloc/song_bloc/bloc/song_bloc.dart';
import '../../../bloc/song_control_bloc/bloc/audio_control_bloc.dart';
import '../../../helpers/widgets/custom_app_bar.dart';

class PlayMusicPage extends StatefulWidget {

  final String songName;
  final String songFile;
  final int songID;
  List<SongDataModel>? songList;
  List<NewSongDataModel>? newSongList;
  List<AlbumDataMusicModel>? albumSongList;

  PlayMusicPage({super.key, required this.songName,
    required this.songFile, required this.songID, this.songList,
    this.newSongList, this.albumSongList});


  @override
  State<PlayMusicPage> createState() => PlayMusicPageState();
}

class PlayMusicPageState extends State<PlayMusicPage> with WidgetsBindingObserver , SingleTickerProviderStateMixin {

  bool loop = false;
  List playlistIDs = [];
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));
    BlocProvider.of<PlaylistBloc>(context).add(SearchSongIDEvent(songID: widget.songID));
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        body: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
            listener: (context, state) {
              context
                  .read<AudioControlBloc>()
                  .add(PlaySong(currentSong: context.read<CurrentSelectedSongBloc>().currentSelectedSong!));
            },
            builder: (context, state) {


              if (state is LoadingNewSong) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SelectedSongFetched) {

                var songID = state.songModel.id;

                return Container(
                  height: double.infinity,
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(state.songModel.imageSource!,),
                      fit: BoxFit.fitHeight,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: CustomAppBar(
                              title: "Now Playing",
                              singerName: state.songModel.album == null
                                  ? ""
                                  : state.songModel.album!.singer == null
                                  ? ""
                                  :  state.songModel.album!.singer!.name == null
                                  ? ""
                                  : state.songModel.album!.singer!.name!,
                              haveMenuButton: false,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    state.songModel.name!,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white60),
                                  ),
                                ),
                                BlocBuilder<PlaylistBloc, PlaylistState>(
                                builder: (context, state) {
                                  bool isFavorite = state.isFavorite;
                                return Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                    _controller
                                        .reverse()
                                        .then((value) => _controller.forward());

                                    if(isFavorite){
                                      BlocProvider.of<PlaylistBloc>(context).add(AddMusicToPlaylistEvent(songID: songID!));
                                      BlocProvider.of<PlaylistBloc>(context).add(SaveSongIDEvent(songID: songID));
                                      print("true");
                                    }else{
                                      BlocProvider.of<PlaylistBloc>(context).add(RemoveMusicFromPlaylistEvent(musicID: songID!));
                                      BlocProvider.of<PlaylistBloc>(context).add(RemoveSongIDEvent(songID: songID));
                                      print("false");
                                    }
                                  },
                                  child: ScaleTransition(
                                    scale: Tween(begin: 0.7, end: 1.0).animate(
                                        CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                                    child: isFavorite
                                            ? const Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.red,
                                        )
                                            : const Icon(
                                          Icons.favorite_border,
                                          size: 30,
                                        )


                                  ),
                                )
                            );
    })
                              ],
                            ),
                          ),
                          CustomCircularSeekBar(
                            songImage: state.songModel.imageSource!,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              right: 20,
                              left: 20
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    DownloadButton(
                                        songFilePath: state.songModel.fileSource!,
                                        songName: state.songModel.name!
                                    ),
                                    NormalizeButton()
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<SongBloc, SongState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              padding: const EdgeInsets.all(1),
                                              // style: AppTheme.lightTheme.iconButtonTheme.style,
                                              onPressed: () {
                                                context
                                                    .read<CurrentSelectedSongBloc>()
                                                    .add(PlayPreviousSong(songs: BlocProvider.of<SongBloc>(context).songs));
                                              },
                                              icon: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      offset: const Offset(
                                                        1.0,
                                                        1.0,
                                                      ),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 7.0,
                                                    ),
                                                    BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
                                                  ]),
                                                  child: const Icon(Icons.skip_previous_rounded,
                                                    color: Colors.white,)));
                                        }),
                                    BlocBuilder<AudioControlBloc, AudioControlState>(
                                      buildWhen: (previous, current) {
                                        if (previous is AudioPlayedState && current is AudioPlayedState) {
                                          return false;
                                        } else {
                                          return true;
                                        }
                                      },
                                      builder: (context, state) {
                                        return IconButton(
                                            padding: const EdgeInsets.all(1),
                                            onPressed: () async {
                                              if (state is AudioPausedState) {
                                                BlocProvider.of<AudioControlBloc>(context).add(ResumeSong());
                                              } else {
                                                BlocProvider.of<AudioControlBloc>(context).add(PauseSong());
                                              }
                                            },
                                            icon: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.1),
                                                    offset: const Offset(
                                                      1.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 10.0,
                                                    spreadRadius: 7.0,
                                                  ),
                                                  BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
                                                ]),
                                                child: state is AudioPlayedState
                                                    ? const Icon(
                                                  Icons.pause,
                                                  color: Colors.white,
                                                  size: 40,)
                                                    : const Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                  size: 40,)));
                                      },
                                    ),

                                    BlocBuilder<SongBloc, SongState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              padding: const EdgeInsets.all(1),
                                              onPressed: () {
                                                context
                                                    .read<CurrentSelectedSongBloc>()
                                                    .add(PlayNextSong(songs: BlocProvider.of<SongBloc>(context).songs));
                                              },
                                              icon: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      offset: const Offset(
                                                        1.0,
                                                        1.0,
                                                      ),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 7.0,
                                                    ),
                                                    BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
                                                  ]),
                                                  child: const Icon(Icons.skip_next_rounded,
                                                    color: Colors.white,)));

                                        })
                                  ],
                                ),
                                StreamBuilder(
                                    stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        final currentDurationSecond = (snapshot.data?.inSeconds ?? 0);
                                        final currentDurationMinute = (snapshot.data?.inMinutes ?? 0).toString().padLeft(2 , "0");
                                        return Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [Row(
                                                    children: [
                                                      Text(currentDurationMinute),
                                                      Text(":"),
                                                      Text((currentDurationSecond % 60).toString().padLeft(2 , "0")),
                                                    ],
                                                  ), Row(
                                                    children: [
                                                      Text("${state.songModel.minute}".padLeft(2 , "0")),
                                                      Text(":"),
                                                      Text("${state.songModel.second}".padLeft(2 , "0")),
                                                    ],
                                                  )],
                                                )),
                                            SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                                              child: Slider(
                                                  activeColor: Colors.purple,
                                                  inactiveColor: Colors.black,
                                                  value: (snapshot.data?.inSeconds)?.toDouble() ?? 0,
                                                  max: double.parse(state.songModel.minute ?? "0") * 60 + double.parse(state.songModel.second ?? "0"),
                                                  min: 0,
                                                  // activeColor: Theme.of(context).colorScheme.background,
                                                  onChangeEnd: (value) {},
                                                  onChanged: (val) {
                                                    BlocProvider.of<AudioControlBloc>(context).seekTo(Duration(seconds: val.toInt()));
                                                  }),
                                            )
                                          ],
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    })),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PlayListButton(),
                                    RepeatButton(loop: loop)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          const Spacer(),
                        widget.newSongList == null
                            && widget.songList == null
                            && widget.albumSongList == null
                            ? Container()
                            : Flexible(
                              flex: 4,
                              child: ContainerAllSongsList(
                                newSongList: widget.newSongList,
                                songList: widget.songList,
                                albumSongList: widget.albumSongList,
                                songName: state.songModel.name!
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            }
        )
    );
  }


}