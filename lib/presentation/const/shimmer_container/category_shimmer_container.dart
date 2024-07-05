import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmerContainer extends StatelessWidget {

  final int shimmerLength;
  const CategoryShimmerContainer({super.key, required this.shimmerLength});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shimmerLength,

          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.grey[400]!,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5.0)),
                      width: MediaQuery.of(context).size.height / 8,
                      height: MediaQuery.of(context).size.height / 8
                  ),
                )
            );
          }),
    );
  }
}