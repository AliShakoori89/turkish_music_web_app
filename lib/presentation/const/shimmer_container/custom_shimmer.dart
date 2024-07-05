import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.grey[400]!,
        child: Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5.0)),
        )
    );
  }
}
