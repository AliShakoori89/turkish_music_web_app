import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

class PlaylistContainer extends StatelessWidget {
  const PlaylistContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.0052,
          vertical: MediaQuery.of(context).size.width * 0.055),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      child: AnimatedListView(
        duration: 100,
        scrollDirection: Axis.horizontal,
        children: List.generate(
            10,
            (index) => Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.030,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/tarkan.png")
                      )
                    ),
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                )),
      ),
    );
  }
}
