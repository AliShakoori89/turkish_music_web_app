import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlayingPageImageShimmer extends StatelessWidget {
  const PlayingPageImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.grey[400]!,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black12,
            shape: BoxShape.circle),
      ),
    );
  }
}
