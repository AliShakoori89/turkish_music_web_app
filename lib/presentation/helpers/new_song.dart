import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:turkish_music_app/presentation/const/title.dart';

class NewSong extends StatelessWidget {
  const NewSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "New Song", haveSeeAll: true),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.055,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: AnimatedGridView(
                duration: 100,
                crossAxisCount: 2,
                mainAxisExtent: 256,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List.generate(
                    4,
                        (index) => Card(
                      elevation: 50,
                      shadowColor: Colors.black,
                      color: Colors.grey[700],
                      child: const SizedBox(
                        width: double.infinity,
                      ),
                    ))),
          ),
        )
      ],
    );
  }
}
