import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/domain/repositories/album_repository.dart';
import 'package:turkish_music_app/domain/repositories/category_repository.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';
import 'package:turkish_music_app/domain/repositories/new_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_box_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/singer_repository.dart';
import 'package:turkish_music_app/domain/repositories/user_repository.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/playing_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/singer_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/bloc/audio_control_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/ui/authenticate_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';

Future<void> main() async{


  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = (prefs.getString('accessToken') == null)
      ? false
      : true;

  // await SimpleAudio.init(
  //   useMediaController: true,
  //   shouldNormalizeVolume: false,
  //   dbusName: "com.erikas.SimpleAudio",
  //   actions: [
  //     MediaControlAction.rewind,
  //     MediaControlAction.skipPrev,
  //     MediaControlAction.playPause,
  //     MediaControlAction.skipNext,
  //     MediaControlAction.fastForward,
  //   ],
  //   androidNotificationIconPath: "mipmap/ic_launcher",
  //   androidCompactActions: [1, 2, 3],
  //   applePreferSkipButtons: true,
  //
  // );

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {

  final bool isLoggedIn;
  // final List result;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                UserBloc(SignUserRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                SongBloc(SongRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                NewSongBloc(NewSongRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                AlbumBloc(AlbumRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                SingerBloc(SingerRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                InternetConnectionBloc(InternetConnectionRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                PlayingSongBloc(IsPlayingMusicRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                AudioControlBloc()),
        BlocProvider(
            create: (BuildContext context) =>
                PlayBoxBloc(PlayBoxRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                CategoryBloc(CategoryRepository())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        home:
        // result.isNotEmpty && result[0].rawAddress.isNotEmpty ?
        isLoggedIn
            ? MainPage(
        )
            :
        // const MainPage()
        AuthenticatePage()
            // : const ErrorInternetConnectionPage()
      ),
    );
  }
}


