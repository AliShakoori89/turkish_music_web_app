import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/title.dart';

class FeaturedContainer extends StatelessWidget {
  const FeaturedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "Featured"),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15)
          ),
        ),
      ],
    );
  }
}
