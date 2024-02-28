import 'package:flutter/material.dart';

class SongDetailList extends StatelessWidget {

  final Icon customIcon;
  final String title;
  const SongDetailList({super.key, required this.customIcon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        customIcon,
        SizedBox(width: 10,),
        DefaultTextStyle(
            style: TextStyle(
                fontSize: 12,
                color: Colors.white
            ),
            child: Text(title)),
      ],
    );
  }
}
