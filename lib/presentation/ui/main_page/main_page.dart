import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import '../../const/custom_icon/music_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    const HomePage(),
    const SearchPage(),
    const MusicPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNavigationBar(),
        body: _children[_selectedIndex]

    );
  }

  BottomNavigationBar customBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(MusicIcon.music, size: 18),
          label: 'My Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}