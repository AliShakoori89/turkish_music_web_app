import 'dart:async';
import 'dart:io';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/domain/repositories/album_repository.dart';
import 'package:turkish_music_app/domain/repositories/category_repository.dart';
import 'package:turkish_music_app/domain/repositories/download_repository.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/domain/repositories/mini_playing_container_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_button_state_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_list_repository.dart';
import 'package:turkish_music_app/domain/repositories/new_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/play_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/recently_play_song_repository.dart';
import 'package:turkish_music_app/domain/repositories/singer_repository.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';
import 'package:turkish_music_app/domain/repositories/user_repository.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/category_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/fetch_user_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
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
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/categories/category_item/category_songs_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/new_song_container/new_song_page/all_new_song_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/all_singer_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page_component/singer_container/singer_page/singer_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/song_page/download_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/song_page/playlist_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page/search_page.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;


const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

FutureOr<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // await DefaultCacheManager().emptyCache();
  await requestStoragePermission();

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = (prefs.getString('accessToken') == null)
      ? false
      : true;

  // Define the callback for notification responses
  void onNotificationResponse(NotificationResponse response) {
    if (response.actionId == 'id_open') {
      print('Open button tapped! Payload: ${response.payload}');
      // Add logic to open or play the file
    } else if (response.actionId == 'id_dismiss') {
      print('Dismiss button tapped!');
      // Handle dismiss action if needed
    }
  }

  // Initialize notification settings
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onNotificationResponse,);

  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://f1cdf7541efb2cab8d645bdbcfa21b5c@o4508205725253632.ingest.us.sentry.io/4508205732265984';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      // Note: Profiling alpha is available for iOS and macOS since SDK version 7.12.0
      options.profilesSampleRate = 1.0;
    },
    appRunner: () =>   runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>
        MyApp(isLoggedIn: isLoggedIn)
      // )
    )
  );
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

  GoogleSignInAccount? _currentUser;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late bool isOffline = false;

  @override
  void initState() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    checkInternetConnectionWithErrorHandling();

    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    googleSignIn.signInSilently();
    requestNotificationPermission();
    super.initState();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
      } else {
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
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

  void requestNotificationPermission() async {
    final plugin = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (plugin != null) {
      final bool granted = await plugin.requestNotificationsPermission() ?? false;
      if (granted) {
        print("Notification permission granted............................................");
      } else {
        print("Notification permission denied............................................");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final GoogleSignInAccount? user = _currentUser;

    AppInfo appInfo = AppInfo(
        appName: 'Turkish Music', // Your app name
        appVersion: '1.0.1', // Your app version
        platform: Platform.operatingSystem, // App Platform, android or ios
        environment: 'development', // Environment in which app is running, production, staging or development etc.
        appLanguage: 'en',
        appId: '' // App language ex: en, es etc. Optional.
    );

    DialogConfig dialogConfig = DialogConfig(
        dialogStyle: DialogStyle.material,
        title: 'App update required!',
        updateButtonTitle: 'Update Now');

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                UserBloc(UserRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                FetchUserBloc(UserRepository())),
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
      child: AppUpgradeAlert(
        appInfo: appInfo, // Pass app metadata
        dialogConfig: dialogConfig, // Pass dialog customization
        xApiKey: 'YTgxN2RhYmYtMzllYi00MGUwLTkyZTYtMDhmOGI1NmJiMWFj',
        child: MaterialApp.router(
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
                      widget.isLoggedIn || user != null
                          ? MainPage()
                          : AuthenticatePage(googleSignIn: googleSignIn)
                          : const ErrorInternetConnectionPage();
                    },
                    routes: [
                      GoRoute(
                        path: MainPage.routeName,
                        builder: (context, state){
                          return MainPage();
                        },),
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
                        path: SearchPage.routeName,
                        builder: (context, state){
                          return SearchPage();
                        },
                      ),
                      GoRoute(
                          path: AllSingerPage.routeName,
                          builder: (context, state){
                            return AllSingerPage();
                          }
                      ),
                      GoRoute(
                          path: AllNewSongsPage.routeName,
                          builder: (context, state){
                            return AllNewSongsPage();
                          }
                      ),
                      GoRoute(
                          path: DownloadPage.routeName,
                          builder: (context, state){
                            return DownloadPage();
                          }
                      ),
                      GoRoute(
                          path: PlaylistPage.routeName,
                          builder: (context, state){
                            return PlaylistPage();
                          }
                      ),
                      GoRoute(
                        path: 'CategorySongPage',
                        name: CategorySongPage.routeName,
                        builder: (context, state) {
                          // Validate and parse the `state.extra` to ensure it's of type `Map` and contains required fields
                          final extra = state.extra;
                          if (extra is! Map || !extra.containsKey('imageSource') || !extra.containsKey('categoryName') || !extra.containsKey('categoryID')) {
                            throw Exception("Invalid or missing `extra` data for CategorySongPage.");
                          }
        
                          return CategorySongPage(
                            imageSource: extra['imageSource'] as String,
                            categoryName: extra['categoryName'] as String,
                            categoryID: extra['categoryID'] as int,
                          );
                        },
                      ),
                      GoRoute(
                        path: 'PlaySongPage',
                        name: PlaySongPage.routeName,
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(
                            transitionDuration: Duration(seconds: 1),
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
      ),
    );
  }
}
