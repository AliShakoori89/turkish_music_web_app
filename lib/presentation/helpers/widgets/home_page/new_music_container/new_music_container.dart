import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/home_page/new_music_container/new_music.dart';

class NewMusicContainer extends StatefulWidget {

  @override
  State<NewMusicContainer> createState() => NewMusicContainerState();
}

class NewMusicContainerState extends State<NewMusicContainer>{

  @override
  Widget build(BuildContext context) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.011,
          ),
          NewMusic(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.055,
          ),
        ],
      );
  }
}
