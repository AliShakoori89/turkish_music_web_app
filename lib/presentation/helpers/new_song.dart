import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/title.dart';

class NewSong extends StatelessWidget {
  const NewSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "New Song", haveSeeAll: true),
        GridView.builder(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.055,
            bottom: MediaQuery.of(context).size.width * 0.055,
          ),
          shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 4,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
              );
            }),
      ],
    );
  }
}
