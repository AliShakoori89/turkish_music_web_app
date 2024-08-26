import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page/music_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/mini_palying_container.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';
import '../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../bloc/mini_playing_container_bloc/event.dart';
import '../../bloc/mini_playing_container_bloc/state.dart';
import '../../const/custom_icon/music_icons.dart';
import '../../const/error_internet_connection_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key, required this.orientation});
  final Orientation orientation;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentRoute = 0;

  Connectivity connectivity = Connectivity();
  IconData? icon;
  String connectionType = "No internet connection";
  bool isOffline = true;
  late StreamSubscription<ConnectivityResult> connectionSubscription;

  @override
  void initState() {
    super.initState();
    getConnectivity();

    connectionSubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);

    BlocProvider.of<MiniPlayingContainerBloc>(context).add(ReadSongIDForMiniPlayingSongContainerEvent());

  }

  @override
  void dispose() {
    connectionSubscription.cancel();
    super.dispose();
  }

  Future<void> getConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
      getConnectionType(result);

    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      icon = Icons.signal_wifi_connected_no_internet_4;
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    getConnectionType(result);

    if(result == ConnectivityResult.none){
      setState(() {
        isOffline = true;
      });
    }
    else{
      setState(() {
        isOffline = false;
      });
    }
  }

  void getConnectionType(result) {
    if(result == ConnectivityResult.mobile) {
      connectionType = "Internet connection is from Mobile data";
      icon = Icons.network_cell;
    }else if(result == ConnectivityResult.wifi) {
      connectionType = "Internet connection is from wifi";
      icon = Icons.network_wifi_sharp;
    }else if(result == ConnectivityResult.ethernet){
      connectionType = "Internet connection is from wired cable";
      icon = Icons.settings_ethernet;
    }else if(result == ConnectivityResult.bluetooth){
      connectionType = "Internet connection is from Bluetooth tethering";
      icon = Icons.network_wifi_sharp;
    }else if(result == ConnectivityResult.none){
      connectionType = "No internet connection";
      icon = Icons.signal_wifi_connected_no_internet_4;
    }
  }

  @override
  Widget build(BuildContext context) {

    void navigateRoutes(int selectedIndex) {
      setState(() {
        currentRoute = selectedIndex;
      });
    }

    List myRoutes = [
      Padding(
        padding: EdgeInsets.only(
          // bottom: MediaQuery.of(context).size.height * 0.09 + 50,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.07,
            ),
            child: HomePage(orientation: widget.orientation),
          )
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.09 + 50,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const ProfilePage()
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.09 + 50,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: MusicPage(
            orientation: widget.orientation,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.09,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: searchPage(
            orientation: widget.orientation,
          ),
        ),
      ),
    ];

    return !isOffline
        ? WillPopScope(
            onWillPop: (){
              exit(0);
            },
          child: Scaffold(
          body: Stack(
            children: [
              myRoutes[currentRoute],
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  VerticalNavBar(
                    selectedIndex: currentRoute,
                    height: widget.orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.3
                        : MediaQuery.of(context).size.height * 0.3,
                    width: widget.orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.12
                        : MediaQuery.of(context).size.width * 0.04,
                    backgroundColor: Colors.purple.withOpacity(0.7),
                    borderRadius: 15,
                    onItemSelected: (value) {
                      setState(() {
                        navigateRoutes(value);
                      });
                    },
                    items: const [
                      VerticalNavBarItem(
                          customIcon: Icons.home,
                          iconSize: 25
                      ),
                      VerticalNavBarItem(
                          customIcon: Icons.person,
                          iconSize: 25
                      ),
                      VerticalNavBarItem(
                          customIcon: MusicIcon.music,
                          iconSize: 20
                      ),
                      VerticalNavBarItem(
                          customIcon: Icons.search,
                          iconSize: 25
                      ),
                    ],
                  ),
                  BlocBuilder<MiniPlayingContainerBloc,
                      MiniPlayingContainerState>(
                      builder: (context , state) {

                        bool visibility = state.visibility;
                        int songID = state.songID;
                        int albumID = state.albumID;

                        return MiniPlayingContainer(
                          visibility: visibility,
                          songID: songID,
                          albumID: albumID,
                          orientation: widget.orientation,
                        );
                      }
                  ),
                ],
              )
            ],
          )
          ),
        )
        : const ErrorInternetConnectionPage();
  }
}