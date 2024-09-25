import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/domain/repositories/album_repository.dart';
import 'package:turkish_music_app/domain/repositories/category_repository.dart';
import 'package:turkish_music_app/domain/repositories/download_repository.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/domain/repositories/mini_playing_container_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_button_state_repository.dart';
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
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_button_state_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/playing_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/recently_play_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/singer_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/audio_control_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/const/error_internet_connection_page.dart';
import 'package:turkish_music_app/presentation/ui/authentication_page/authenticate_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/all_singer_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/singer_page.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page.dart';
import 'data/model/album_model.dart';
import 'data/model/singer_model.dart';
import 'data/model/song_model.dart';


FutureOr<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await requestStoragePermission();

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = (prefs.getString('accessToken') == null)
      ? false
      : true;

  runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>
            MyApp(isLoggedIn: isLoggedIn)
  // )
  ); // Wrap your app
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


class MyApp extends StatefulWidget {

  final bool isLoggedIn;

  MyApp({key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConnectivityResult _connectionStatus;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late bool isOffline = false;

  @override
  void initState() {
    _connectionStatus = ConnectivityResult.none;
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    checkInternetConnectionWithErrorHandling();
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  checkInternetConnectionWithErrorHandling() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      return false;  // Default to false on error
    }

    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.vpn) {
      isOffline = true;
    } else {
      isOffline = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    print("widget.isLoggedIn           "+widget.isLoggedIn.toString());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                UserBloc(UserRepository())),
        BlocProvider(
            create: (context) =>
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
        BlocProvider(
            create: (BuildContext context) =>
                PlayButtonStateBloc(PlayButtonStateRepository())),
      ],
      child: MaterialApp.router(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        routerConfig: GoRouter(
            routes: [
              GoRoute(
                  path: "/",
                  builder: (context, state){
                    return isOffline ?
                    widget.isLoggedIn
                        ? MainPage()
                        : AuthenticatePage()
                        : const ErrorInternetConnectionPage();
                  },
                  routes: [
                    GoRoute(
                      path: HomePage.routeName,
                      builder: (context, state){
                        return HomePage();
                      },),
                    GoRoute(
                      path: SingerPage.routeName,
                      builder: (context, state){
                        return SingerPage();
                      },
                    ),
                    GoRoute(
                        path: AllSingerPage.routeName,
                        builder: (context, state){
                          return AllSingerPage();
                        }
                    ),
                    GoRoute(
                      path: 'PlaySongPage',
                      name: PlaySongPage.routeName,
                      pageBuilder: (context, state) {
                        final extra = state.extra as Map<String, dynamic>?;

                        return CustomTransitionPage(
                          transitionDuration: Duration(seconds: 2),
                          child: PlaySongPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);  // Bottom to top transition
                            const end = Offset.zero;
                            const curve = Curves.easeOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        );
                      },
                    ),

                  ]
              ),
            ]
        ),
      ),
    );
  }
}
