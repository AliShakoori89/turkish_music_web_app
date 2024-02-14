import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import 'package:turkish_music_app/presentation/helpers/under_image_singar_and_song_name.dart';

class FeaturedContainer extends StatefulWidget {
  const FeaturedContainer({super.key});

  @override
  State<FeaturedContainer> createState() => _FeaturedContainerState();
}

class _FeaturedContainerState extends State<FeaturedContainer> {

  int _currentIndex = 0;

  List cardList=[
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          image: const DecorationImage(
              image: ExactAssetImage('assets/images/tarkan1.png'),
              fit: BoxFit.fill
          )
      ),
    )
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: "New Song", haveSeeAll: true),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.055,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                // height: MediaQuery.of(context).size.height / 5,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 5,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: cardList.map((card) {
                    return Builder(builder: (BuildContext context) {
                      return SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width / 0.5,
                        child: Card(
                          elevation: 0,
                          child: card,
                          // shadowColor: Colors.white,
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 4,
                  child: Opacity(
                    opacity: 0.8,
                    child: Row(
                      children: map<Widget>(cardList, (index, url) {
                        return Container(
                          width: 5.0,
                          height: 5.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ))
            ],
          ),
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: MediaQuery.of(context).size.width * 0.0052,
        //       vertical: MediaQuery.of(context).size.width * 0.055),
        //   height: MediaQuery.of(context).size.height * 0.2,
        //   decoration: BoxDecoration(
        //     color: Colors.blueAccent,
        //     borderRadius: BorderRadius.circular(15),
        //     image: const DecorationImage(
        //       image: AssetImage("assets/images/tarkan1.png"),
        //         fit: BoxFit.fill
        //     )
        //   ),
        // ),
        const UnderImageSingerAndSongName(
            singerName: "Tarkan",
            songName: "Araftaeim"),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.055,
        ),
      ],
    );
  }
}
