import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restart_app/restart_app.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';
import '../helpers/widgets/header.dart';

class ErrorInternetConnectionPage extends StatefulWidget {
  const ErrorInternetConnectionPage({super.key});

  @override
  State<ErrorInternetConnectionPage> createState() => _ErrorInternetConnectionPageState();
}

var refreshKey = GlobalKey<RefreshIndicatorState>();
Random random = Random();
int limit = random.nextInt(10);

class _ErrorInternetConnectionPageState extends State<ErrorInternetConnectionPage> {

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      Restart.restartApp(webOrigin: '/');
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
            child: AppHeader()),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: ListView(
                )
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/gif/error_connection.gif"))
                  ),
                ),
              ),
              const Flexible(
                  flex: 1,
                  child: Text("No Internet Connect")),
              const Flexible(
                  flex: 1,
                  child: Text("please Check Your Connection !!!"))
            ],
          ),
        )

      ),
    );
  }
}
