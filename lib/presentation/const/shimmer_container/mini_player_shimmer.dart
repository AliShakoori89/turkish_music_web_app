import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MiniPlayerShimmer extends StatelessWidget {
  const MiniPlayerShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
        baseColor: Colors.purple.withValues(alpha: 0.1),
        highlightColor: Colors.white,
        child: Container(
          margin: EdgeInsets.all(5),
          height: (size.width / size.height) < 1.5
              ? size.height / 15
              : size.height / 10,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.purple, ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          width: double.infinity,
        )
    );
  }
}
