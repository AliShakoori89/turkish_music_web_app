import 'package:flutter/cupertino.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page.dart';

class MiniPlayingContainerRouteToPlayingSongPage extends PageRouteBuilder {

  AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

  MiniPlayingContainerRouteToPlayingSongPage() : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) =>
      PlaySongPage(
          songName: songName,
          songFile: songFile,
          songID: songID,
          albumSongList: albumSongList,
          singerName: singerName,
          songImage: songImage,
          pageName: pageName));

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0, 1), end: Offset(.0, .0))
          .animate(_controller),
      child: PlaySongPage(
          songName: songName,
          songFile: songFile,
          songID: songID,
          albumSongList: albumSongList,
          singerName: singerName,
          songImage: songImage,
          pageName: pageName));
    );
  }
