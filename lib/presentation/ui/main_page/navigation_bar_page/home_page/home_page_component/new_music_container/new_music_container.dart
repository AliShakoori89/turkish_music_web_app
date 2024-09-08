import 'package:flutter/material.dart';

import 'new_music.dart';

class NewMusicContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.011,
          ),
          NewSong(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.055,
          ),
        ],
      );
  }
}
