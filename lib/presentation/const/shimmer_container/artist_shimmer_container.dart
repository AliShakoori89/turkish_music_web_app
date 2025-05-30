import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArtistShimmerContainer extends StatelessWidget {

  final int shimmerLength;
  const ArtistShimmerContainer({super.key, required this.shimmerLength});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,

          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.grey[400]!,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle),
                      width: 70,
                      height: 70
                  ),
                )
            );
          }),
    );
  }
}
