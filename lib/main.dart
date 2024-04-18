import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/domain/repositories/album_repository.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/domain/repositories/music_repository.dart';
import 'package:turkish_music_app/domain/repositories/new_music_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_box_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_music_repository.dart';
import 'package:turkish_music_app/domain/repositories/singer_repository.dart';
import 'package:turkish_music_app/domain/repositories/user_repository.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/audio_control/bloc/audio_control_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/is_playing_music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/singer_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/ui/authenticate_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = (prefs.getString('accessToken') == null)
      ? false
      : true;

  await SimpleAudio.init(
    useMediaController: true,
    shouldNormalizeVolume: false,
    dbusName: "com.erikas.SimpleAudio",
    actions: [
      MediaControlAction.rewind,
      MediaControlAction.skipPrev,
      MediaControlAction.playPause,
      MediaControlAction.skipNext,
      MediaControlAction.fastForward,
    ],
    androidNotificationIconPath: "mipmap/ic_launcher",
    androidCompactActions: [1, 2, 3],
    applePreferSkipButtons: true,

  );

  runApp(MyApp(isLoggedIn: isLoggedIn),);
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
                MusicBloc(MusicRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                NewMusicBloc(NewMusicRepository())),
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
                IsPlayingMusicBloc(IsPlayingMusicRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                CurrentSelectedSongBloc()),
        BlocProvider(
            create: (BuildContext context) =>
                AudioControlBloc()),
        BlocProvider(
            create: (BuildContext context) =>
                PlayBoxBloc(PlayBoxRepository())),
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
            ? const MainPage()
            : const MainPage()
        // AuthenticatePage()
            // : const ErrorInternetConnectionPage()
      ),
    );
  }
}


