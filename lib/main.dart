import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/domain/repositories/album_repository.dart';
import 'package:turkish_music_app/domain/repositories/category_repository.dart';
import 'package:turkish_music_app/domain/repositories/download_repository.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/domain/repositories/mini_playing_container_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_list_repository.dart';
import 'package:turkish_music_app/domain/repositories/new_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_box_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/recently_play_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/singer_repository.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';
import 'package:turkish_music_app/domain/repositories/user_repository.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/playing_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/recently_play_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/singer_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/audio_control_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/ui/authenticate_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page.dart';
import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:turkish_music_app/request_permission_manager.dart';


FutureOr<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = (prefs.getString('accessToken') == null)
      ? false
      : true;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}


Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    // Request the permission
    if (await Permission.storage.request().isGranted) {
      // The permission is granted
      print("Permission Granted");
    } else {
      // The permission is denied
      print("Permission Denied");
    }
  } else if (status.isGranted) {
    // The permission is already granted
    print("Permission Already Granted");
  }
}


class MyApp extends StatelessWidget {

  final bool isLoggedIn;

  MyApp({key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                UserBloc(UserRepository())),
        BlocProvider(create: (context) => SongBloc(SongRepository())),
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
        BlocProvider(
            create: (BuildContext context) =>
                PlaylistBloc(PlayListRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                MiniPlayingContainerBloc(MiniPlayingContainerRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                DownloadBloc(DownloadRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                RecentlyPlaySongBloc(RecentlyPlaySongRepository())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => MainPage(),
          },
        home:
        // result.isNotEmpty && result[0].rawAddress.isNotEmpty ?
        isLoggedIn
            ? MainPage()
            : AuthenticatePage()
            // : const ErrorInternetConnectionPage()
      ),
    );
  }


}
