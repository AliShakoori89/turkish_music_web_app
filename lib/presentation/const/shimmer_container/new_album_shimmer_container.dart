import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewAlbumShimmerContainer extends StatelessWidget {

  const NewAlbumShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,

          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.grey[400]!,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2
                  ),
                )
            );
          }),
    );
  }
}
