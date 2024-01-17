import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  Map<int, Color> color = {
    50:const Color.fromRGBO(0, 0, 0, 1.0),
    100:const Color.fromRGBO(0, 0, 0, 1.0),
    200:const Color.fromRGBO(0, 0, 0, 1.0),
    300:const Color.fromRGBO(0, 0, 0, 1.0),
    400:const Color.fromRGBO(0, 0, 0, 1.0),
    500:const Color.fromRGBO(0, 0, 0, 1.0),
    600:const Color.fromRGBO(0, 0, 0, 1.0),
    700:const Color.fromRGBO(0, 0, 0, 1.0),
    800:const Color.fromRGBO(0, 0, 0, 1.0),
    900:const Color.fromRGBO(0, 0, 0, 1.0),
  };

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: MaterialColor(0xFF880E4F, color), brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
