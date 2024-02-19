import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/domain/repositories/sign_up_user_repository.dart';
import 'package:turkish_music_app/presentation/bloc/authentication_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/authentication_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/authentication_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/register_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/service/authentication_service.dart';
import 'package:turkish_music_app/presentation/ui/login_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(
    DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => RepositoryProvider<AuthenticationService>(
        create: (context) {
          return FakeAuthenticationService();
        },
        child: BlocProvider<AuthenticationBloc>(
          create: (context) {
            final authService =
            RepositoryProvider.of<AuthenticationService>(context);
            return AuthenticationBloc(authService)..add(AppLoaded());
          },
          child:
          const MyApp(),
        )
    ) // Wrap your app
  ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                RegisterBloc(SignUserRepository())),
        // BlocProvider(
        //     create: (BuildContext context) =>
        //         AuthenticationBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
                return MainPage(user: state.user!);
              }
              return const LoginPage();
            })
      ),
    );
  }
}


