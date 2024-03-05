import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/domain/repositories/music_repository.dart';
import 'package:turkish_music_app/domain/repositories/sign_up_user_repository.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/const/error_internet_connection_page.dart';
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
                InternetConnectionBloc(InternetConnectionRepository())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: BlocBuilder<InternetConnectionBloc, InternetConnectionState>(builder: (context, state) {
          if(state.internetConnectionStatus) {
            return isLoggedIn ? const MainPage() : const AuthenticatePage();
          }else{
            return const ErrorInternetConnectionPage();
          }
        })
      ),
    );
  }
}


