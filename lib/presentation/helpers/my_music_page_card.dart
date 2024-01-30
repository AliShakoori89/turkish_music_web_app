import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/custom_divider.dart';

class MyMusicPageCard extends StatelessWidget {

  final String title;
  final IconData customIcon;

  const MyMusicPageCard({super.key, required this.title, required this.customIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 8,
                right: 8,
                bottom: 15
              ),
              child: Row(
                children: [
                  Icon(customIcon),
                  const SizedBox(width: 10,),
                  Text(title),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
            size: 20,)
          ],
        ),
        CustomDivider()
      ],
    );
  }
}
