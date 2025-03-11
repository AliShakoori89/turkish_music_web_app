import 'package:flutter/material.dart';

import '../../../../../../const/title.dart';
import 'new_song.dart';

class NewMusicContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          TitleText(
            title: "New Songs",
            haveSeeAll: true,
          ),
          NewSong(),
          SizedBox(
            height: 30,
          ),
        ],
      );
  }
}
