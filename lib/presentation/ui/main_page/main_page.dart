import 'package:flutter/material.dart';
import 'package:turkish_music_app/data/model/user_model.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';

import '../../const/custom_icon/music_icons.dart';

class MainPage extends StatefulWidget {

  final UserModel user;
  const MainPage({super.key, required this.user});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentRoute = 0;

  @override
  Widget build(BuildContext context) {

    // print("user                                                  "+widget.user.data!.email!);

    void navigateRoutes(int selectedIndex) {
      setState(() {
        currentRoute = selectedIndex;
      });
    }

    List myRoutes = [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const HomePage()
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
        child: const ItemSearchPage(),
      ),
    ];

    return Scaffold(
        body: Center(
          child: Row(
            children: [
              Stack(
                children: [
                  myRoutes[currentRoute],
                  Align(
                    alignment: Alignment.bottomLeft,
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
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}