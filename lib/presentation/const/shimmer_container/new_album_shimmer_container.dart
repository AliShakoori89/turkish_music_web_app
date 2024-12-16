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
          mainAxisExtent: MediaQuery.of(context).size.width / 3,
          crossAxisSpacing: MediaQuery.of(context).size.width / 9,
          children: List.generate(
              4,
                  (index) =>
                      Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.grey[400]!,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                              borderRadius: BorderRadius.circular(5.0)),
                          width: MediaQuery.of(context).size.width / 8,
                        )
                      )))
    );
  }
}
