import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.songName, required this.singerName});

  final String songName;
  final String singerName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: AnimatedListView(
          duration: 100,
          scrollDirection: Axis.vertical,
          children: List.generate(
              10,
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                height: MediaQuery.of(context).size.height * 0.065,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                      image: AssetImage("assets/images/tarkan.png"),
                                  fit: BoxFit.fill)
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.03,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(songName),
                                  Text(singerName)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.more_vert,
                            size: 20,)),
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}
