import 'package:flutter/material.dart';

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
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.030,),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            );
          }),
    );
  }
}
