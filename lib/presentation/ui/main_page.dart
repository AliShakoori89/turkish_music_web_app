import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';
import '../const/custom_icon/music_icons.dart';
import '../const/error_internet_connection_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});


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
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: HomePage()
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const ProfilePage()
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: MusicPage(),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: searchPage(),
      ),
    ];

    return !isOffline
        ? Scaffold(
        body: Center(
          child: Stack(
            children: [
              myRoutes[currentRoute],
              Positioned(
                bottom: 120,
                right: 0,
                child: VerticalNavBar(
                  selectedIndex: currentRoute,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.10,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  borderRadius: 15,
                  onItemSelected: (value) {
                    setState(() {
                      navigateRoutes(value);
                    });
                  },
                  items: const [
                    VerticalNavBarItem(
                        customIcon: Icons.home,
                        iconSize: 25.0
                    ),
                    VerticalNavBarItem(
                        customIcon: Icons.person,
                        iconSize:25.0
                    ),
                    VerticalNavBarItem(
                        customIcon: MusicIcon.music,
                        iconSize:18.0
                    ),
                    VerticalNavBarItem(
                        customIcon: Icons.search,
                        iconSize:25.0
                    ),
                  ],
                ),
              )
            ],
          )
        )
    )
        : const ErrorInternetConnectionPage();
  }
}