import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewSongShimmerContainer extends StatelessWidget {
  const NewSongShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      height: orientation == Orientation.portrait
          ? 300
          : 220,
      child: Shimmer.fromColors(
          baseColor: Colors.black12,
          highlightColor: Colors.grey[400]!,
          child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
            ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black12,),
              width: MediaQuery.of(context).size.width * 0.99,
              height: MediaQuery.of(context).size.height * 0.09
          )
      )
    );
  }
}
