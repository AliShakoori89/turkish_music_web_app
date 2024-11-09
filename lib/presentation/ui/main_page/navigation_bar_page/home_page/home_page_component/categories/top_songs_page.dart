import 'package:flutter/material.dart';

class TopSongPage extends StatefulWidget {

  static String routeName = "TopSongPage";
  final String imageSource;

  const TopSongPage({super.key, required this.imageSource});

  @override
  State<TopSongPage> createState() => _TopSongPageState();
}

class _TopSongPageState extends State<TopSongPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(widget.imageSource)
        ],
      ),
    );
  }
}
