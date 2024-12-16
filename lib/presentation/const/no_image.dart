import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class NoImage extends StatelessWidget {
  const NoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesNoImage),
                fit: BoxFit.fill
            ),
            color: Colors.black12,
            shape: BoxShape.circle),
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2
    );
  }
}
