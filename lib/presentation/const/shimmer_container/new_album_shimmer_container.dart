import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:shimmer/shimmer.dart';

class NewAlbumShimmerContainer extends StatelessWidget {

  const NewAlbumShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      child: AnimatedGridView(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisExtent: 170,
          crossAxisSpacing: 50,
          children: List.generate(
              4,
                  (index) =>
                      Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.grey[400]!,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                              borderRadius: BorderRadius.circular(5.0)),
                          width: 50,
                        )
                      )))
    );
  }
}
