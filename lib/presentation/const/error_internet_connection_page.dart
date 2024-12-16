import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import '../helpers/widgets/header.dart';

class ErrorInternetConnectionPage extends StatefulWidget {
  const ErrorInternetConnectionPage({super.key});

  @override
  State<ErrorInternetConnectionPage> createState() => _ErrorInternetConnectionPageState();
}

var refreshKey = GlobalKey<RefreshIndicatorState>();
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
        body: LayoutBuilder(builder: (context, constraints) {
          return RefreshIndicator(
            onRefresh: refreshList,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/gif/error_connection.gif"))),
                        ),
                        Text(
                          "No Internet Connection",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                        Text("please Check Your Connection !!!",
                            textAlign: TextAlign.center)
                      ],
                    ),
                  )),
            ),
          );
        })
    ));
  }
}
