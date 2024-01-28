import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const MainPage(),
    );
  }
}


