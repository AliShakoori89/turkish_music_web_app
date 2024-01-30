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
        const TitleText(title: "New Song", haveSeeAll: false),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.055,
            bottom: MediaQuery.of(context).size.width * 0.055,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.42,
            child: AnimatedGridView(
                duration: 100,
                crossAxisCount: 2,
                mainAxisExtent: 170,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: List.generate(
                    4,
                        (index) =>
                            Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 50,
                          shadowColor: Colors.black,
                          color: Colors.grey[700],
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/tarkan.png"),
                                  fit: BoxFit.fill)
                            ),
                            width: double.infinity,
                          ),
                        ))),
          ),
        )
      ],
    );
  }
}
